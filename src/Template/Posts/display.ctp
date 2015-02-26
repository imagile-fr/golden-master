<a href="/">&laquo; Accueil</a>
<div class="post">
  <h1><?php echo $post->title; ?></h1>
  <div class="body">
    <?php echo nl2br($post->body); ?>
  </div>
</div>
<div class="other-posts">
  <h3>Autres posts</h3>
  <ul>
  <?php foreach ($posts as $post): ?>
    <li>
    <?php echo $this->Html->link($post->title, array(
      'controller' => 'posts', 'action' => 'display', $post->id
    )); ?>
    </li>
  <?php endforeach ?>
  </ul>
</div>
