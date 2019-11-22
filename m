Return-Path: virtio-dev-return-6385-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8622A985EC2
	for <virtio-dev@lists.oasis-open.org>; Fri, 22 Nov 2019 14:48:34 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 22 Nov 2019 14:48:22 +0000
Message-Id: <20191122144824.483847-1-stefanha@redhat.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 0/2] virtio-fs: add notification queue
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
To: virtio-dev@lists.oasis-open.org
Cc: mszeredi@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, vgoyal@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

This patch series adds the notification queue to the VIRTIO specification.
This new virtqueue carries device->driver FUSE notify messages.  They are
currently unused but will be necessary for file locking, which can block fo=
r an
unbounded amount of time and therefore needs a asynchronous completion even=
t
instead of a request/response buffer that consumes space in the request
virtqueue until the operation completes.

Patch 1 corrects an oversight I noticed: the file system device was not add=
ed
to the Conformance chapter.

Stefan Hajnoczi (2):
  virtio-fs: add file system device to Conformance chapter
  virtio-fs: add notification queue

 conformance.tex | 21 +++++++++++++++++
 virtio-fs.tex   | 63 +++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 74 insertions(+), 10 deletions(-)

--=20
2.23.0


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

