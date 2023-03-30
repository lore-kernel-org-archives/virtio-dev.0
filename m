Return-Path: <virtio-dev-return-11860-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986F6C7619A
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 21:50:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C7DDC3F54D
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 21:50:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 954E5986580
	for <virtio-dev@archiver.kernel.org>; Thu, 30 Mar 2023 21:50:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 74E5A98655C; Thu, 30 Mar 2023 21:50:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EE377986561
	for <virtio-dev@lists.oasis-open.org>; Thu, 30 Mar 2023 21:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-IronPort-AV: E=Sophos;i="5.98,306,1673884800"; 
   d="scan'208";a="226745720"
IronPort-SDR: RqpfWVhuwEkTKffosHD5y6m5oTC41t5HuHjf0nhLTb9s8DIITsC1Gb90BL83RO5MPiMbxWonqE
 7zmkiN65Xiz+GlccjjgXIdwS2vzgtclBfKLqktFPl3ErBRaeZR3vBMMtWZ4pqYGHZ6FpfrFthz
 /4innVuz7DRbfnybGItsBJP8CVmMp/3cHPYT1piitHuhe1OupRq+oFOMxtkpA4NMlz3oQLPWoa
 h//Hz3kel5uuGPBH7llRxZJeV62FU1Zi7ZWN0MimA8x1oNdyE9VkWtzMUIiyokE03o//4Rb7x/
 wyI=
IronPort-SDR: 2c5NTS0AOs6wAOfyUADIPyFRkL7KPrDNHQMSh1BoOOoBcL7WAn+zk+sn2/b7QrHt9uaQkiQaPq
 jYfc5+nj4lVYZoItwDjJ/mC6ZR94CNGh/m102WqdxeUSwvfNZLanHET3qrN3VJcQbRab6qI3Tl
 hV+EjPG8g9qEsIwB+GLTPS+j/J9MffZz0jIePc5wM46nCp3mxLUGQjpoJPNVOksy6t/hQFd/kW
 wXCgRPXH8hz3uQ+axq5oR2uMRUzNl+VpwK5QMvqs7koy/6mICMSEAp6NqxA75YRL7wka1kCIbE
 +gE=
WDCIronportException: Internal
From: Dmitry Fomichev <dmitry.fomichev@wdc.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Stefan Hajnoczi <stefanha@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Sam Li <faithilikerun@gmail.com>
Cc: virtio-dev@lists.oasis-open.org,
	virtualization@lists.linux-foundation.org,
	Dmitry Fomichev <dmitry.fomichev@wdc.com>
Date: Thu, 30 Mar 2023 17:49:51 -0400
Message-Id: <20230330214953.1088216-1-dmitry.fomichev@wdc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] [PATCH v2 0/2] virtio-blk: fix a few problems in ZBD-related code

This two-part series contains code fixes that are related to the
recently added support for zoned block devices in virtio-blk
driver.

The original ZBD patchset that was merged to the kernel -next was not
the latest and greatest version. The first patch of this series is
essentially a diff between the current code and the final revision of
the original patchset.

The second patch fixes a problem that is observed when a host-managed
zoned device is virtualized via virtio-blk and the driver kernel is
configured without ZBD support (CONFIG_BLK_DEV_ZONED not set). In this
case, the driver must not allow the device scan to succeed in order to
avoid erroneous device operation that may cause data loss. The
second patch adds this currently missing functionality.

v1 -> v2:

 - address nits from Damien
 - add Review-by tags from Stefan and Damien

Dmitry Fomichev (2):
  virtio-blk: migrate to the latest patchset version
  virtio-blk: fix ZBD probe in kernels without ZBD support

 drivers/block/virtio_blk.c      | 269 ++++++++++++++++++++------------
 include/uapi/linux/virtio_blk.h |  18 +--
 2 files changed, 182 insertions(+), 105 deletions(-)

-- 
2.34.1


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

