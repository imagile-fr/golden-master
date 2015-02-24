<h1>Articles</h1>
<?php foreach ($posts as $post): ?>
  <div class="post">
    <h2>
      <?php echo $this->Html->link($post['posts']['title'], array(
        'controller' => 'posts', 'action' => 'display', $post['posts']['id']
        )); ?>
    </h2>
    <div class="body">
      <p><?php echo $this->Text->truncate($post['posts']['body']); ?></p>
    </div>
  </div>
<?php endforeach ?>
