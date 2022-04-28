from setuptools import setup

setup(
    name='bs',
    version='1.0.0',
    description='A template engine for Make',
    url='http://github.com/michaell4438/bs',
    author='Michael Lachut',
    author_email='michael@lachut.com',
    license='GPL3',
    packages=["."],
    entry_points=dict(
        console_scripts=['bs=bs:exec']
    )
)