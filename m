Return-Path: <virtio-dev-return-9952-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5B0719863BA
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Sep 2022 02:29:31 +0000 (UTC)
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Sun, 18 Sep 2022 22:29:20 -0400
Message-Id: <20220919022921.946344-3-dmitry.fomichev@wdc.com>
In-Reply-To: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
References: <20220919022921.946344-1-dmitry.fomichev@wdc.com>
MIME-Version: 1.0
Subject: [virtio-dev] [PATCH 2/3] virtio-blk: add a placeholder for secure erase config
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="US-ASCII"; x-default=true
To: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@opensource.wdc.com>, Stefan Hajnoczi <stefanha@gmail.com>, Hannes Reinecke <hare@suse.de>, Sam Li <faithilikerun@gmail.com>
Cc: linux-block@vger.kernel.org, virtio-dev@lists.oasis-open.org, Dmitry Fomichev <dmitry.fomichev@wdc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

The configuration space layout in virtio specification defines more
members than are currently present in the kernel virtio_blk_config
structure. Specifically, there are some fields defined in the spec
that are related to secure erase operation support. The newly added
zoned device extension adds even more fields after the secure erase
section.

In order to keep the zoned configuration space data field alignment
consistent with the virtio specification, append a field of the size
that is equal to the total byte size of secure erase-related fields to
virtio_blk_config.
---
 include/uapi/linux/virtio_blk.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/uapi/linux/virtio_blk.h b/include/uapi/linux/virtio_bl=
k.h
index d888f013d9ff..d9122674a539 100644
--- a/include/uapi/linux/virtio_blk.h
+++ b/include/uapi/linux/virtio_blk.h
@@ -121,6 +121,9 @@ struct virtio_blk_config {
 =09__u8 write_zeroes_may_unmap;
=20
 =09__u8 unused1[3];
+
+=09/* Secure erase fields that are defined in the virtio spec */
+=09__u8 sec_erase[12];
 } __attribute__((packed));
=20
 /*
--=20
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

