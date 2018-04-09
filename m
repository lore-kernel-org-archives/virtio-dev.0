Return-Path: virtio-return-3052-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Mon,  9 Apr 2018 20:58:37 +0200
Message-Id: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [PATCH 0/5] fixes and tweaks for virtio v1.1 
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Some of these are more and some are less important. Please
be careful, there is always a chance that I misunderstood something
and that I'm trying to change for the worse.

I've identified some other weak point's too, but tried to
proceed in order the more grave and the better I think I
understand it (and thus propose a fix) the higher the priority.

Some stuff I've left for my notifiers patch set. This one
and that one will have to get merged if both turn out to
be good.

Halil Pasic (5):
  packed-ring: fix used descriptors but meant buffers
  consistency: clean up stale  wording for v1.1 terms
  packed-packed: fix supplying buffers description
  packed-ring: reposition drivernormative on driver notifications
  packed-ring: tweak driver code example

 content.tex     |   14 ++++----
 packed-ring.tex |   96 +++++++++++++++++++++++++++++-------------------------
 2 files changed, 59 insertions(+), 51 deletions(-)


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

