Return-Path: <virtio-dev-return-11893-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F8CC76188
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:07 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B9C7141EEC
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:06 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 755BA9863E6
	for <virtio-dev@archiver.kernel.org>; Mon,  3 Apr 2023 15:03:06 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4A2A79863D6; Mon,  3 Apr 2023 15:03:06 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 383EA9863DE
	for <virtio-dev@lists.oasis-open.org>; Mon,  3 Apr 2023 15:03:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: sZ3mcNxEPfqbC4uVdpm9EQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680534183;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GMp1K8BpR9AnpOsdxoJswPrr2mrEXpJnYY/saVr10Z0=;
        b=uPQxacxaabxcUJqiXU1ymhHo/RLa2IJsUq6BfwP4K3IhqIfhPakQtyTcdGWTXv5fqc
         unz6s2q1Gu+kfya+qN+rXazBAPFga9SHTUim281gLkGjHJkZ0yQuMY10XAJ2msiPNj5u
         PHgIY7eYqw7GQRf6pE43yaR+NczHJPv79ftfkmJClcbh4VkVn3EIRx6y+bHy5Rl8gUlg
         01kZrTcSIkyeNBQmPcPh9AZxUwmOdwCtoh1qWEmorKuoPSRMcfQp3a37nTYwLPX6V1Lr
         RtWLrboaFiu93YtImUjF5d9n8IAEQDIMr0LzzdCbQqgb5+ZAPI/K6yWDfI1yFg0d+vDi
         ggeA==
X-Gm-Message-State: AAQBX9csBAa56kNyAvEmgRfyI2yohP1957WK4eDSm7IqlKIiBXLOrC4O
	be1C1sqChXtA8kka0zOU84f8BtU4CqgTImE3YNFbElZhHA9nT0TyoHdCxXoRQPQKUAqz77v4fQr
	Xp8iMY16vtplq1+3w43Ds6zvpoAqm
X-Received: by 2002:a17:906:a399:b0:930:9385:ce51 with SMTP id k25-20020a170906a39900b009309385ce51mr35028133ejz.68.1680534182873;
        Mon, 03 Apr 2023 08:03:02 -0700 (PDT)
X-Google-Smtp-Source: AKy350bdt61/lkSilxxB3ydZ9tS21DF8sjnedpwH0XPYH1TVwVqW6R6TFPQA2k46LtBLrY+zeG0YtA==
X-Received: by 2002:a17:906:a399:b0:930:9385:ce51 with SMTP id k25-20020a170906a39900b009309385ce51mr35028090ejz.68.1680534182511;
        Mon, 03 Apr 2023 08:03:02 -0700 (PDT)
Date: Mon, 3 Apr 2023 11:02:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Jiri Pirko <jiri@nvidia.com>,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <cover.1680533760.git.mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v11 00/10] Introduce device group and device management


Change log:

since v10:
	addressed lots of comments by Jiri, Stefan. Cornelia, Lngshan, Parav, Max
	Cornelia, do you want to pick up 10/10 separately?

since v9:
	addressed comments by Parav, Max, Cornelia, David and Zhu Lingshan:
		added link to errno header from Linux
		rename _MEM to _MEMBER
		admin vq num is zero based
		clarify who sends commands where
		minor english tweaks
		clarify command length
		specify interaction with sriov capability
		correct commit log - NumVFs can be 0

	i could not decide what should happen when VFs are
	disabled. for now did not specify.

since v8:
	addressed comments by Cornelia - as we agreed on list
	
since v7:
	make high level error codes match linux, with virtio specific codes
		in a separate field
	renamed _ACCEPT to _USE since that's what it does
	clarified forward compatibility and non pci transports
	support multiple admin vqs
	conformance statements
	lots of changes all over the place to I changed author from Max
	to myself. Don't need to take credit but also don't want
	to blame Max for my mistakes.

since v6:

	- removed some extentions intended for future use.
	  We'll do them when we get there.

	- brought back command list query from v5 in a simplified form -
	  it's here to address the case where a single parent
	  can address multiple groups, such as PF addressing
	  transport vq and sriov vfs.

	- attempt to make terminology more formal.
	In particular a term for whoever controls the group.
 	I am still going back
	and forth between "parent" and "owner" - owner might
	be better after all since it will work if we ever
	have a self group. For now it's parent.

TODO (maybe?) - probably ok to defer until this part is upstream:

	Add "all members" member id.

	Add commands for MSI, feature discovery.

	Add commands for transport vq.


My intent is to try and support both SR-IOV and SIOV
usecases with the same structure and maybe even the same
VQ.

For example, it might make sense to split creating/destroying
SIOV devices from the transport passing data from the guest - the
driver would then not negotiate VIRTIO_F_SR_IOV (which
then means auto-provisioning).

More ideas for use-cases:
virtio VF features query and configuration space provisioning
virtio VF resource (queues, msix vectors count) provisioning


Future directions (shouldn't block this patch)
- aborting commands - left for later. or is vq reset enough?
- should we rename structures from admin to group admin?
  left as is for now just in case we soon get more admin things which are
  not group administration. easy to change later.


Michael S. Tsirkin (10):
  virtio: document forward compatibility guarantees
  admin: introduce device group and related concepts
  admin: introduce group administration commands
  admin: introduce virtio admin virtqueues
  pci: add admin vq registers to virtio over pci
  mmio: document ADMIN_VQ as reserved
  ccw: document ADMIN_VQ as reserved
  admin: command list discovery
  admin: conformance clauses
  ccw: document more reserved features

 admin.tex        | 586 +++++++++++++++++++++++++++++++++++++++++++++++
 content.tex      | 113 ++++++++-
 introduction.tex |   3 +
 3 files changed, 700 insertions(+), 2 deletions(-)
 create mode 100644 admin.tex

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

