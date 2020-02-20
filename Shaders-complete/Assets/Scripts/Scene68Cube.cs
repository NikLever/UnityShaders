using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Scene68Cube : MonoBehaviour
{
    Material material;
    Vector4 center;
    float startY;

    // Start is called before the first frame update
    void Start()
    {
        Renderer rend = GetComponent<Renderer>();
        material = rend.material;
        center = new Vector4();
        startY = transform.position.y;
    }

    // Update is called once per frame
    void Update()
    {
        //transform.Rotate(0.0f, 0.4f, 0.0f);

        Vector3 pos = transform.position;
        pos.y = startY + (float)(Math.Sin(Time.time * 3.0) * 0.2);
        transform.position = pos;

        center = pos;

        material.SetVector("_Center", center);
        //Debug.Log(mouse);
    }
}
