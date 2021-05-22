import Food from "./Food"
import Snake from "./Snake"
import ScorePanel from "./ScorePanel"


class GameControl {
    food: Food;
    snake: Snake;
    scorePanel: ScorePanel;
    direction: string = "ArrowRight";
    isLive: boolean = true;

    constructor() {
        this.food = new Food();
        this.snake = new Snake();
        //this.scorePanel = new ScorePanel();
        this.scorePanel = new ScorePanel(10, 5);
        this.init();
    }

    init() {
        document.addEventListener("keydown", this.keydownHandler.bind(this))
        this.run();
    }

    keydownHandler(event: KeyboardEvent) {
        // console.log(event.key);
        this.direction = event.key;
    }

    run() {
        // up: top--
        // down:top++
        // left:left++
        // right:left--
        let X = this.snake.X;
        let Y = this.snake.Y;
        switch (this.direction) {
            case "ArrowUp":
                Y -= 10;
                break;
            case "ArrowDown":
                Y += 10;
                break;
            case "ArrowLeft":
                X -= 10;
                break;
            case "ArrowRight":
                X += 10;
                break;
        }

        if (this.checkEat(X, Y)) {
            console.log("got one!")

        }

        try {
            this.snake.X = X;
            this.snake.Y = Y;
        } catch (err) {
            alert(err.message);
            this.isLive = false;
        } finally {

        }

        this.isLive && setTimeout(this.run.bind(this), 300 - (this.scorePanel.level - 1) * 30);

    }


    checkEat(x: number, y: number) {
        if (x === this.food.X && y == this.food.Y) {
            this.food.change();
            this.scorePanel.addScore();
            this.snake.addBody();
            return true;
        }
    }


}

export default GameControl;
