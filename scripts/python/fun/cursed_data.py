import curses, math, time

def main(stdscr):
    # Initial curses setup
    curses.curs_set(0)            # Hide cursor (make it invisible)
    stdscr.nodelay(True)          # Non-blocking getch() for continuous loop
    stdscr.keypad(True)           # Enable special keys (optional, here for completeness)
    curses.noecho()               # Don't echo keys to the screen

    # Determine screen dimensions
    height, width = stdscr.getmaxyx()

    # Text to animate
    text = "DANCING WAVE"
    N = len(text)
    # Set baseline and amplitude for wave
    baseline = height // 2
    amplitude = min(3, (height - 1) // 2)  # amplitude 3 or smaller if screen is short
    phase = 0.0         # initial phase of the wave
    phase_step = 0.2    # how much to increment phase each frame (controls speed)
    offset_step = 0.5   # phase offset between adjacent letters

    # Animation loop
    while True:
        stdscr.erase()  # clear previous frame from buffer

        # Draw each letter at its new position
        for i, ch in enumerate(text):
            # horizontal position (center the whole text)
            x = (width // 2) - (N // 2) + i
            # vertical position as baseline + sine wave offset
            y = baseline + int(round(amplitude * math.sin(phase + i * offset_step)))
            # Clamp y within screen bounds
            if y < 0: 
                y = 0
            elif y >= height: 
                y = height - 1
            stdscr.addch(y, x, ch)
        stdscr.refresh()    # update the screen with all changes

        # Check for quit key (press 'q' to exit)
        key = stdscr.getch()
        if key == ord('q') or key == ord('Q'):
            break

        # Increment phase and control frame rate
        phase += phase_step
        time.sleep(0.05)

# Start the curses application
curses.wrapper(main)
