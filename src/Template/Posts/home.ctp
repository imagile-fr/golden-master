<h1>Articles</h1>
<?php foreach ($posts as $post): ?>
  <div class="post">
    <h2>
      <?php echo $this->Html->link($post->title, array(
        'controller' => 'posts', 'action' => 'display', $post->id
        )); ?>
    </h2>
    <div class="body">
      <?php echo $this->Text->truncate($post->body); ?>
    </div>
  </div>
<?php endforeach ?>
