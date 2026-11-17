# 1.6.5. plotly (Python)

plotly는 인터랙티브 웹 기반 시각화를 제공하는 라이브러리입니다.

## 1.6.5.1. 설치 및 기본 사용 (Python 3.13)

```bash
python3.13 -m pip install plotly pandas
```

```python
import plotly.express as px
import plotly.graph_objects as go
import pandas as pd
import numpy as np

# 샘플 데이터
df = px.data.iris()
```

## 1.6.5.2. Express API (간단한 플롯)

```python
# 산점도
fig = px.scatter(df, x='sepal_width', y='sepal_length', 
                 color='species', size='petal_length',
                 title='Iris Dataset')
fig.show()

# 선 그래프
df_time = px.data.gapminder().query("country=='Canada'")
fig = px.line(df_time, x='year', y='lifeExp', title='Life Expectancy in Canada')
fig.show()

# 막대 차트
fig = px.bar(df, x='species', y='sepal_width', color='species')
fig.show()

# 박스플롯
fig = px.box(df, x='species', y='sepal_length', color='species')
fig.show()

# 히스토그램
fig = px.histogram(df, x='sepal_length', color='species', nbins=20)
fig.show()

# 3D 산점도
fig = px.scatter_3d(df, x='sepal_length', y='sepal_width', z='petal_length',
                    color='species', size='petal_width')
fig.show()
```

## 1.6.5.3. Graph Objects API (커스터마이징)

```python
# 기본 선 그래프
fig = go.Figure()
fig.add_trace(go.Scatter(x=[1, 2, 3, 4], y=[10, 11, 12, 13],
                         mode='lines+markers', name='Line 1'))
fig.add_trace(go.Scatter(x=[1, 2, 3, 4], y=[16, 15, 14, 17],
                         mode='lines+markers', name='Line 2'))
fig.update_layout(title='Custom Line Plot', xaxis_title='X', yaxis_title='Y')
fig.show()

# 히트맵
z = np.random.randn(20, 20)
fig = go.Figure(data=go.Heatmap(z=z, colorscale='Viridis'))
fig.update_layout(title='Heatmap')
fig.show()

# 서브플롯
from plotly.subplots import make_subplots

fig = make_subplots(rows=2, cols=2,
                    subplot_titles=('Plot 1', 'Plot 2', 'Plot 3', 'Plot 4'))

fig.add_trace(go.Scatter(x=[1, 2, 3], y=[4, 5, 6]), row=1, col=1)
fig.add_trace(go.Bar(x=[1, 2, 3], y=[2, 3, 4]), row=1, col=2)
fig.add_trace(go.Scatter(x=[1, 2, 3], y=[6, 5, 4]), row=2, col=1)
fig.add_trace(go.Box(y=[1, 2, 3, 4, 5, 6]), row=2, col=2)

fig.update_layout(height=600, showlegend=False)
fig.show()
```

## 1.6.5.4. 애니메이션

```python
df_anim = px.data.gapminder()

fig = px.scatter(df_anim, x='gdpPercap', y='lifeExp', 
                 animation_frame='year', animation_group='country',
                 size='pop', color='continent', hover_name='country',
                 log_x=True, size_max=55, range_x=[100, 100000], range_y=[25, 90])
fig.show()
```

## 1.6.5.5. 지도 시각화

```python
# 지리적 산점도
df_map = px.data.gapminder().query("year==2007")
fig = px.scatter_geo(df_map, locations='iso_alpha', color='continent',
                     hover_name='country', size='pop',
                     projection='natural earth')
fig.show()

# Choropleth (단계 구분도)
fig = px.choropleth(df_map, locations='iso_alpha',
                    color='lifeExp', hover_name='country',
                    color_continuous_scale=px.colors.sequential.Plasma)
fig.show()
```

## 1.6.5.6. Jupyter 통합

```python
# Jupyter Notebook에서 사용
import plotly.offline as pyo
pyo.init_notebook_mode(connected=True)

# 또는 자동으로 표시
fig.show()

# HTML로 저장
fig.write_html('plot.html')

# 정적 이미지로 저장 (kaleido 필요)
# pip install kaleido
fig.write_image('plot.png')
fig.write_image('plot.pdf')
```

## 1.6.5.7. Dash (웹 대시보드)

```python
# pip install dash
from dash import Dash, html, dcc, Input, Output

app = Dash(__name__)

app.layout = html.Div([
    html.H1('Dashboard'),
    dcc.Graph(id='graph'),
    dcc.Slider(id='slider', min=0, max=10, value=5, step=1)
])

@app.callback(
    Output('graph', 'figure'),
    Input('slider', 'value')
)
def update_graph(value):
    fig = px.bar(x=['A', 'B', 'C'], y=[value, value*2, value*3])
    return fig

if __name__ == '__main__':
    app.run(debug=True)
```

## 1.6.5.8. 스타일 커스터마이징

```python
fig.update_layout(
    title='Custom Title',
    title_font_size=24,
    xaxis_title='X Axis',
    yaxis_title='Y Axis',
    font=dict(family='Arial', size=14, color='black'),
    plot_bgcolor='white',
    paper_bgcolor='#f0f0f0',
    hovermode='x unified'
)

# 축 범위
fig.update_xaxes(range=[0, 10])
fig.update_yaxes(range=[0, 100])

# 범례 위치
fig.update_layout(legend=dict(x=0.01, y=0.99, bgcolor='rgba(255,255,255,0.5)'))
```
