import pygame
import random
import sys

# Initialize Pygame
pygame.init()

# Constants
WINDOW_SIZE = 600
GRID_SIZE = 20
GRID_COUNT = WINDOW_SIZE // GRID_SIZE

# Colors
BLACK = (0, 0, 0)
GREEN = (0, 255, 0)
RED = (255, 0, 0)
WHITE = (255, 255, 255)

# Initialize window
screen = pygame.display.set_mode((WINDOW_SIZE, WINDOW_SIZE))
pygame.display.set_caption('Snake Game')
clock = pygame.time.Clock()

class Snake:
    def __init__(self):
        self.positions = [(GRID_COUNT // 2, GRID_COUNT // 2)]
        self.direction = (1, 0)
        self.grow = False

    def move(self):
        current = self.positions[0]
        x, y = self.direction
        new = (((current[0] + x) % GRID_COUNT), (current[1] + y) % GRID_COUNT)
        
        if new in self.positions[:-1]:
            return False
        
        self.positions.insert(0, new)
        if not self.grow:
            self.positions.pop()
        else:
            self.grow = False
        return True

    def change_direction(self, new_direction):
        x, y = self.direction
        new_x, new_y = new_direction
        if (x, y) != (-new_x, -new_y):
            self.direction = new_direction

class Game:
    def __init__(self):
        self.snake = Snake()
        self.food = self.generate_food()
        self.score = 0

    def generate_food(self):
        while True:
            food = (random.randint(0, GRID_COUNT-1), random.randint(0, GRID_COUNT-1))
            if food not in self.snake.positions:
                return food

    def update(self):
        if not self.snake.move():
            return False
        
        if self.snake.positions[0] == self.food:
            self.snake.grow = True
            self.food = self.generate_food()
            self.score += 1
        return True

    def draw(self):
        screen.fill(BLACK)
        
        # Draw snake
        for position in self.snake.positions:
            rect = pygame.Rect(position[0] * GRID_SIZE, position[1] * GRID_SIZE,
                             GRID_SIZE-1, GRID_SIZE-1)
            pygame.draw.rect(screen, GREEN, rect)
        
        # Draw food
        rect = pygame.Rect(self.food[0] * GRID_SIZE, self.food[1] * GRID_SIZE,
                          GRID_SIZE-1, GRID_SIZE-1)
        pygame.draw.rect(screen, RED, rect)
        
        # Draw score
        font = pygame.font.Font(None, 36)
        score_text = font.render(f'Score: {self.score}', True, WHITE)
        screen.blit(score_text, (10, 10))

def main():
    game = Game()
    
    while True:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()
            elif event.type == pygame.KEYDOWN:
                if event.key == pygame.K_UP:
                    game.snake.change_direction((0, -1))
                elif event.key == pygame.K_DOWN:
                    game.snake.change_direction((0, 1))
                elif event.key == pygame.K_LEFT:
                    game.snake.change_direction((-1, 0))
                elif event.key == pygame.K_RIGHT:
                    game.snake.change_direction((1, 0))

        if not game.update():
            break
            
        game.draw()
        pygame.display.flip()
        clock.tick(10)

    # Game Over
    font = pygame.font.Font(None, 74)
    text = font.render('Game Over!', True, WHITE)
    text_rect = text.get_rect(center=(WINDOW_SIZE/2, WINDOW_SIZE/2))
    screen.blit(text, text_rect)
    pygame.display.flip()
    
    # Wait for a moment before quitting
    pygame.time.wait(2000)
    pygame.quit()
    sys.exit()

if __name__ == "__main__":
    main()
