Return-Path: virtio-return-3061-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 00:11:24 +0200
Message-Id: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
Subject: [virtio] [RFC PATCH 0/3] rework notifications terminology
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

While discussing XXXX using available and used buffer notifications
consistently for virqueue notifications (driver to device and vice versa
respectively) seemed like a good idea.

It turned out surprisingly invasive however, and I find it necessary to
confirm, this is really the path we want to walk, before investing even more
time.

This series limits itself to the core and to the ccw transport. It ain't
typical to the device types to make statements about notifications, but at
least net has some words on interrupts. I did not get these immediately so I've
left that out for now. 

I choose ccw as demonstrator on how to bridge the abstract with the transport
specific, because that is the transport I'm most familiar with. I do not expect
difficulties with the other ones.


Halil Pasic (3):
  notifications: unify notifications wording in core
  notifications:notifications as basic virtio facility
  ccw: map common notifications terminology to ccw

 cl-os.tex       |    2 +-
 conformance.tex |    8 ++--
 content.tex     |   92 ++++++++++++++++++++++++++++++++++++++++++++++++++-----
 packed-ring.tex |   59 +++++++++++++++++++---------------
 split-ring.tex  |   72 +++++++++++++++++++++++++------------------
 5 files changed, 164 insertions(+), 69 deletions(-)


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

