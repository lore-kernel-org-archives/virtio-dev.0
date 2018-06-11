Return-Path: virtio-return-3118-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 11 Jun 2018 18:11:52 +0200
Message-Id: <1528733518-24950-1-git-send-email-pasic@linux.ibm.com>
Subject: [virtio] [PATCH v2 0/6] rework notifications terminology
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
List-ID: <virtio-dev.lists.oasis-open.org>

Abstract 
--------
The terminology around notifications is currently somewhat
fragmented. Unify notifications terminology using available and used
buffer notification consistently for the virtqueue notifications.
Consistent use of the term configuration change notification is of
concern.

Changelog:
---------
v1 -> v2:
* Addressed Stefan's comments (mostly typos, grammar and inconsistencies).
  Thanks Stefan!
* Rebased onto the current master.

RFC --> v1:
* Devices and the transports PCI and MMIO were omitted.
Now the rework should be complete.
* Addressed review comments and minor changes for the first
three patches. 

Sorry it took so long to respin.

Halil Pasic (6):
  notifications: unify notifications wording in core
  notifications: notifications as basic virtio facility
  ccw: map common notifications terminology to ccw
  pci: map common notifications terminology to PCI
  mmio: map common notifications terminology to MMIO
  notifications: update notifications terminology for devices

 cl-os.tex       |    2 +-
 conformance.tex |   10 ++--
 content.tex     |  165 +++++++++++++++++++++++++++++++++++++++++-------------
 packed-ring.tex |   61 +++++++++++---------
 split-ring.tex  |   72 ++++++++++++++----------
 5 files changed, 207 insertions(+), 103 deletions(-)


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

