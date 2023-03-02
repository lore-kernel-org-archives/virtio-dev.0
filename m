Return-Path: <virtio-dev-return-11364-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 169F1C6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:27 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 454F82A88B
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:26 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F47A9867F1
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 13:05:25 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D5A41986688; Thu,  2 Mar 2023 13:05:24 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5661F986678
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 13:04:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: jtlRqi4-M8KSLfuRclg3HA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677762293;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ob7Ois4jg+d7af7Oos3pCDSGaKPYj5l/OdXY+5VK6KA=;
        b=vJHNmMojZr4YMsJDA2Suzsd1S61N+UmegoxsC2wyMxAmPpFe9R7BQeMgjVGH6nkWcm
         sRSUVXvQ+ihYJVZPrn/B7a8aU+agfgcmdNJiYJhiFYJfnzp6gk3e3YrSE8AmH6WScb+3
         n2FdQyknFbLoHZMdHJExFRgaOIqZE0n7tWEEZ2BAjDAr1Ar6dlv//mzdDP8bjg+0mqML
         4DMr/V0NsY435l3mvXiSkMt0jRfS/NRUoYtybEHscWyE5LRTJKqS80W1vU2+8YFHjLfV
         A+WdVVKkSSwy6PaES0qC20bcfVyFZUpZ99hGOg+Wgma68DWIg5o2PkrG6l1fIdp0lMWn
         d43A==
X-Gm-Message-State: AO0yUKWWRtfEHfepgFUxP9xR1xSzSWmxRnoaUau0jZ1fVsK0qp/qF3YY
	2D/RgHGNOV4KTNGgssTq7EyzxI1QKhamXk4p1mPNqeky/ZqZrUdkhb91UFSRoFbMQWZEmbiUgrq
	oscKTKZ8cEH/b1lTIPNNpAQosNybM
X-Received: by 2002:a05:600c:a297:b0:3eb:2f3b:4477 with SMTP id hu23-20020a05600ca29700b003eb2f3b4477mr7291077wmb.28.1677762293226;
        Thu, 02 Mar 2023 05:04:53 -0800 (PST)
X-Google-Smtp-Source: AK7set+9ASoMPrq/+NeWGCmncGqxxAqHZwD/js0KYqj+4KpKl5VQTJZphdxxp1PoAd/ExOrbVIVKdg==
X-Received: by 2002:a05:600c:a297:b0:3eb:2f3b:4477 with SMTP id hu23-20020a05600ca29700b003eb2f3b4477mr7291054wmb.28.1677762292933;
        Thu, 02 Mar 2023 05:04:52 -0800 (PST)
Date: Thu, 2 Mar 2023 08:04:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, mst@redhat.com, cohuck@redhat.com,
	sgarzare@redhat.com, stefanha@redhat.com, nrupal.jani@intel.com,
	Piotr.Uminski@intel.com, hang.yuan@intel.com
Cc: virtio@lists.oasis-open.org, Zhu Lingshan <lingshan.zhu@intel.com>,
	pasic@linux.ibm.com, Shahaf Shuler <shahafs@nvidia.com>,
	Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <cover.1677761896.git.mst@redhat.com>
MIME-Version: 1.0
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] [PATCH v10 00/10] Introduce device group and device management

Change log:

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

This is out of RFC, since we have two commands which are useful
to discover supported group types (ATM can be none or SR-IOV).


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

 admin.tex        | 540 +++++++++++++++++++++++++++++++++++++++++++++++
 content.tex      | 112 +++++++++-
 introduction.tex |   3 +
 3 files changed, 653 insertions(+), 2 deletions(-)
 create mode 100644 admin.tex

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

