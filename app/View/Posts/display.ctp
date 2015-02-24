<a href="/">&laquo; Accueil</a>
<div class="post">
  <h1><?php echo $post[0]['posts']['title']; ?></h1>
  <div class="body">
    <?php echo nl2br($post[0]['posts']['body']); ?>
  </div>
</div>
<div class="other-posts">
  <h3>Autres posts</h3>
  <ul>
  <?php foreach ($posts as $post): ?>
    <li>
    <?php echo $this->Html->link($post['posts']['title'], array(
      'controller' => 'posts', 'action' => 'display', $post['posts']['id']
    )); ?>
    </li>
  <?php endforeach ?>
  </ul>
</div>
