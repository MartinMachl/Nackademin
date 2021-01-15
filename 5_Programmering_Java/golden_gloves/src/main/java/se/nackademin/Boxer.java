package se.nackademin;

public class Boxer {
    String name;
    String weightClass;
    double hitPower;
    double stamina;
    double speed;
    double stat;

    Boxer(String name, String weightClass, double hitPower, double speed, double stamina) {
        this.name = name;
        this.weightClass = weightClass;
        this.hitPower = hitPower;
        this.speed = speed;
        this.stamina = stamina;
    }

    public void setName(String name) {
        this.name = name;
    }

    String getName() {
        return name;
    }

    public void setWeight(String weightClass) {
        this.weightClass = weightClass;
    }

    String getWeight() {
        return weightClass;
    }

    public void setPower(double hitPower) {
        this.hitPower = hitPower;
    }

    double getPower() {
        return hitPower;
    }

    public void setStamina(double stamina) {
        this.stamina = stamina;
    }

    double getStamina() {
        return stamina;
    }

    public void setSpeed(double speed) {
        this.speed = speed;
    }

    double getSpeed() {
        return speed;
    }

    // Makes a copy of an object to use in fight
    // so the fight does not effect the original object
    public void copy(Boxer x) {
        this.setName(x.getName());
        this.setWeight(x.getWeight());
        this.setPower(x.getPower());
        this.setSpeed(x.getSpeed());
        this.setStamina(x.getStamina());
    }

    // returns a double that will simulate the health of the boxer
    double getStat() {
        return getPower() + getSpeed() + getStamina();
    }

    // changes the attributes hitPower and speed of an object
    // depending on the value of hitPower
    public void addPower() {
        if (getPower() > 95.00) {
            setPower(getPower() * 1.00);
            setSpeed(getSpeed() * 0.85);
        } else if (getPower() > 80.00) {
            setPower(getPower() * 1.05);
            setSpeed(getSpeed() * 0.89);
        } else if (getPower() > 60.00) {
            setPower(getPower() * 1.15);
            setSpeed(getSpeed() * 0.92);
        } else if (getPower() > 40.00) {
            setPower(getPower() * 1.20);
            setSpeed(getSpeed() * 0.95);
        } else {
            setPower(getPower() * 1.25);
            setSpeed(getSpeed() * 0.98);
        }
    }

    // changes the attributes hitPower and speed of an object
    // depending on the value of speed
    public void addSpeed() {
        if (getSpeed() > 95.00) {
            setSpeed(getSpeed() * 1.00);
            setPower(getPower() * 0.85);
        } else if (getSpeed() > 80.00) {
            setSpeed(getSpeed() * 1.05);
            setPower(getPower() * 0.89);
        } else if (getSpeed() > 60.00) {
            setSpeed(getSpeed() * 1.15);
            setPower(getPower() * 0.92);
        } else if (getSpeed() > 40.00) {
            setSpeed(getSpeed() * 1.20);
            setPower(getPower() * 0.95);
        } else {
            setSpeed(getSpeed() * 1.25);
            setPower(getPower() * 0.98);
        }
    }

    // changes the attributes stamina of an object
    // depending on the value of stamina
    public void addStamina() {
        if (getStamina() > 95.00) {
            setStamina(getStamina() * 1.00);
        } else if (getStamina() > 80.00) {
            setStamina(getStamina() * 1.05);
        } else if (getStamina() > 60.00) {
            setStamina(getStamina() * 1.15);
        } else if (getStamina() > 40.00) {
            setStamina(getStamina() * 1.20);
        } else {
            setStamina(getStamina() * 1.25);
        }
    }
}
