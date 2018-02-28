Return-Path: virtio-return-2937-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Thu, 1 Mar 2018 01:31:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1519860484-7936-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH v9 00/16] packed ring layout spec
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This addresses comments on v8.

Thanks a lot to all reviewers of v8 - I hope we are
finally there or almost there.


A compiled version can
be found under https://github.com/oasis-tcs/virtio-docs.git

virtio-v1.1-packed-wd09-diff.pdf  virtio-v1.1-packed-wd09.pdf

for redline and clean versions, respectively.
If you are interested in changes from v8, that's in

virtio-v1.1-w08-to-wd09-diff.pdf

in this directory.

Note: please do not try to edit the pdf and post comments
in the edited file. Please post comments in a text
format, as pdfs are not archived with the list.

TODO: support for actual passthrough devices will likely
require more new features, such as requirement for
stronger memory barriers.

Note: should this proposal be accepted and approved, one or more
      claims disclosed to the TC admin and listed on the Virtio TC
      IPR page https://github.com/oasis-tcs/virtio-admin/blob/master/IPR.md
      might become Essential Claims.

Changes from v8:

 packed-ring: clarify wording on s/g conformance
 split-ring: typo: aligment
 packed-ring: typo: aligment
 packed-ring: clarify multi-buffer requests
 packed-ring: necessary, not sufficient condition
 packed-ring: support skipping used descritors
 packed-ring: fix pseudo code
 packed-ring: format pseudocode using spaces
 packed-ring: drop << in pseudocode
 packed-ring: clarify event suppression format
 packed-ring: chained descriptors are always on
 VIRTIO_F_NOTIFICATION_DATA: switch to bitfields
 introduction: document bitfield notation
 VIRTIO_F_NOTIFICATION_DATA: minor cleanups
 content: VIRTIO_F_NOTIFICATION_DATA is option
 VIRTIO_F_NOTIFICATION_DATA: improve formatting

Changes from v7:
- new notitfication_data feature, supported for all
  transports and formats
- addressed all outstanding comments

Changes from v6:
- isolate in-order feature to a separate set of patches
  (reduces scope in case there's more discussion around it)
- support in-order option for split rings
- update all references to available/used ring in spec
  to a format-agnostic terminology
- minor changes to event suppression format
- minor changes to notification format
- lots of new conformance clauses

Changes from v5:
- scope reductions (see below). We can add more
  features down the road, hopefully reduced scope will be enough
  to finalize spec soon.
- cleanup and integrate in the spec
- pseudo-code

Deferred features:
- dropped _F_DESC_LIST, 1.0 includes this unconditionally, we
  can do same
- dropped event structure change notifications - needed for
  efficient hardware implementations but let's add this on top

3 1st patches just move text around so all virtio 1.0
things are in the same place. 2 last ones add the new layout

Option to mark descriptors as not generating events isn't
yet implemented. Again, let's add this on top.

I also note that for hardware implementations, a different
set of memory barriers is needed. Again, let's add this on top

Michael S. Tsirkin (16):
  introduction: document bitfield notation
  content: move 1.0 queue format out to a separate section
  content: move ring text out to a separate file
  content: move virtqueue operation description
  content: len -> used length, used ring -> vq
  content: generalize transport ring part naming
  content: generalize rest of text
  split-ring: generalize text
  split-ring: typo: aligment
  packed virtqueues: more efficient virtqueue layout
  content: in-order buffer use
  packed-ring: add in order support
  split-ring: in order feature
  VIRTIO_F_NOTIFICATION_DATA: extra data to devices
  makediff: update to show diff from master
  REVISION: set to 1.1 packed wd09

 REVISION         |   2 +-
 conformance.tex  |   5 +-
 content.tex      | 919 ++++++++++++++-----------------------------------------
 introduction.tex |  18 ++
 makediff.sh      |   3 +-
 notifications.c  |   3 +
 packed-ring.tex  | 704 ++++++++++++++++++++++++++++++++++++++++++
 split-ring.tex   | 689 +++++++++++++++++++++++++++++++++++++++++
 8 files changed, 1655 insertions(+), 688 deletions(-)
 create mode 100644 notifications.c
 create mode 100644 packed-ring.tex
 create mode 100644 split-ring.tex

-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

