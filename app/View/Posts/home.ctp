<h1>Articles</h1>
<?php foreach ($posts as $post): ?>
  <div class="post">
    <h2>
      <?php echo $this->Html->link($post['Post']['title'], array(
        'controller' => 'posts', 'action' => 'display', $post['Post']['id']
        )); ?>
    </h2>
    <div class="body">
      <p><?php echo $this->Text->truncate($post['Post']['body']); ?></p>
    </div>
  </div>
<?php endforeach ?>
