Return-Path: virtio-return-2995-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
Date: Fri, 9 Mar 2018 23:23:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1520629942-36324-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio] [PATCH v10 00/13] packed ring layout spec
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This is a proposal to implement an alternative ring layout.  The
idea is to have a r/w descriptor in a ring structure, replacing
the used and available ring, index and descriptor buffer.

This is more efficient and easier for devices to implement than
the 1.0 layout.

Additionally, a new feature flag is proposed that makes devices
promise to process descriptors in-order. With this feature
drivers can also be made simpler and more efficient.

Discussion and performance analysis of this is in Michael
Tsirkin's kvm forum 2016 and 2017 presentations.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/3

---

This revision addresses review comments on v9.

Thanks a lot to all reviewers of earlier revisions!

I plan to start voting on this shortly.

A compiled version can
be found under https://github.com/oasis-tcs/virtio-docs.git

See

virtio-v1.1-packed-wd10-diff.pdf  virtio-v1.1-packed-wd10.pdf

for redline and clean versions, respectively.

If you are interested in changes from v9, that's in

virtio-v1.1-packed-w09-to-wd10-diff.pdf

in the same directory.

Note: please do not try to edit the pdf and post comments
in the edited file. Please post comments in a text
format, as pdfs are not archived with the list.

TODO: support for actual passthrough devices will likely
require more new features, such as requirement for
stronger memory barriers.


Changes since v9:
- corrected pseudo-code to work correctly without IN_ORDER
  (since that's what the accompanying text says).
- new bit-field notation
- update format for the event suppression structure
- prefix packed ring structures with pvirtq_ for consistency
  and to avoid confusion with the split ring structures
- deferred NOTIFICATION_DATA patches - will post separately,
  they need more review by s390 editor, and proof of
  concept code is not ready yet (needs host kernel support).

Note: should this proposal be accepted and approved, one or more
      claims disclosed to the TC admin and listed on the Virtio TC
      IPR page https://github.com/oasis-tcs/virtio-admin/blob/master/IPR.md
      might become Essential Claims.


Michael S. Tsirkin (13):
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

 conformance.tex  |   5 +-
 content.tex      | 808 ++++++++-----------------------------------------------
 introduction.tex |  41 +++
 packed-ring.tex  | 714 ++++++++++++++++++++++++++++++++++++++++++++++++
 split-ring.tex   | 689 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 1563 insertions(+), 694 deletions(-)
 create mode 100644 packed-ring.tex
 create mode 100644 split-ring.tex

-- 
MST


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

