Return-Path: SRS0=KMw5=FK=redhat.com=mst@kernel.org
Date: Fri, 16 Feb 2018 09:20:50 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v8 00/16] packed ring layout spec
Message-ID: <20180216092050-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Tiwei Bie <tiwei.bie@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dhanoa, Kully" <kully.dhanoa@intel.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This addresses comments on v7. A compiled version can
be found under https://github.com/oasis-tcs/virtio-docs.git

virtio-v1.1-packed-wd08-diff.pdf  virtio-v1.1-packed-wd08.pdf

for redline and clean versions, respectively.

Note: please do not try to edit the pdf and post comments
in the edited file. Please post comments in a text
format, as pdfs are not archived with the list.

TODO: support for actual passthrough devices will likely
require more new features, such as requirement for
stronger memory barriers.

Thanks to everyone who commented! You know who you are.

changes from v7:
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
  content: move 1.0 queue format out to a separate section
  content: move ring text out to a separate file
  content: move virtqueue operation description
  content: replace mentions of len with used length
  content: generalize transport ring part naming
  content: generalize rest of text
  split-ring: generalize text
  packed virtqueues: more efficient virtqueue layout
  content: in-order buffer use
  packed-ring: add in order support
  split-ring: in order feature
  makediff: update to show diff from master
  REVISION: set to 1.1 wd07
  VIRTIO_F_NOTIFICATION_DATA: extra data to devices
  conformance: link the new conformance clause
  REVISION: set for packed-wd07.pdf

 REVISION        |   2 +-
 conformance.tex |   5 +-
 content.tex     | 914 ++++++++++++++------------------------------------------
 makediff.sh     |   3 +-
 packed-ring.tex | 670 +++++++++++++++++++++++++++++++++++++++++
 split-ring.tex  | 689 ++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 1595 insertions(+), 688 deletions(-)
 create mode 100644 packed-ring.tex
 create mode 100644 split-ring.tex

-- 
MST

