Return-Path: <virtio-dev-return-11462-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58110C61DA4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:55:00 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id AC9E126A34
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:54:59 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A09DB9866C9
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:54:59 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 94A709866BF; Mon,  6 Mar 2023 22:54:59 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7F8B89866BE
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 22:54:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: V4H9BBXCNX-zHFaosa3VjQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678143290;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yE8NXpIIrMt0YirsMKpk6yloIvLlYYBMuA7VanmRyfU=;
        b=U/+gzmPPCV9rIbV/rmN8bgHtzSRXl6nCuq+EYuuDDKeewNKNTLhyTeHooThmLTbf+1
         Lrye1fVUKDoYJ/AG/G8qa1sAD8FXVBa+7xjO9q7njAU1KJv0rlmitCViZNzc5x4VwYrb
         ObtVtR+0c2iS86VntHzjdzvANxXF5r9iKmzLRmS2jBX8TXo/vPgt7cfqfnD9eOukwlYm
         2g+K4CFiwKZt0t4T+eWWAmCpUgCYeCgYRe1DMi/eBBHHe/QaY9HcpMGWzuT6ApCzMLWc
         CnvMDaLL7vF8Pdpehckg+vGvsM0utVO8GO9skhwTXYTgIt2QsRmcvMA0cBsOxsOJ2DcH
         8MLQ==
X-Gm-Message-State: AO0yUKXdeM+eTaUte5VP4LXR1sVTJL0dfe9k9IQ+wuPXW8IHqCZx62FA
	0Zva4mcLYF44gRMLWB3RccBFlTlowG4tGxTyyVfg/RRIWqpbTm3ATXDPsjcACVv//IQzoGLKXUC
	r97LLCRJC54rgDTUNiMjgsWjJqK6S
X-Received: by 2002:a5d:680d:0:b0:2c5:6cfe:aabf with SMTP id w13-20020a5d680d000000b002c56cfeaabfmr7643783wru.9.1678143290232;
        Mon, 06 Mar 2023 14:54:50 -0800 (PST)
X-Google-Smtp-Source: AK7set9qnXGU7ZQb2UQfH+86ZHNkAZv43dBc5wzmvIRuUB1baq42yu5PGbNEj+8x30gozCa5bfmWLg==
X-Received: by 2002:a5d:680d:0:b0:2c5:6cfe:aabf with SMTP id w13-20020a5d680d000000b002c56cfeaabfmr7643766wru.9.1678143289849;
        Mon, 06 Mar 2023 14:54:49 -0800 (PST)
Date: Mon, 6 Mar 2023 17:54:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@nvidia.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230306175020-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <ZAXcqqdwfoLokT2l@nanopsycho>
MIME-Version: 1.0
In-Reply-To: <ZAXcqqdwfoLokT2l@nanopsycho>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] [PATCH v10 00/10] Introduce device group and
 device management

On Mon, Mar 06, 2023 at 01:29:30PM +0100, Jiri Pirko wrote:
> Thu, Mar 02, 2023 at 02:04:48PM CET, mst@redhat.com wrote:
> 
> [...]
> 
> >
> >TODO (maybe?) - probably ok to defer until this part is upstream:
> >
> >	Add "all members" member id.
> >
> >	Add commands for MSI, feature discovery.
> >
> >	Add commands for transport vq.
> >
> >
> >My intent is to try and support both SR-IOV and SIOV
> >usecases with the same structure and maybe even the same
> >VQ.
> 
> Sorry to be late to the party, I'm trying to catch up. Is it common to
> have cover letter for features this brief? I mean, from the cover
> letter, I'm totally unable to understand what you are introducing here.
> 
> Could you elaborate about what you are aiming to achive with this?
> Could you shed some usecases perhaps?
> 
> I have to be missing something obvious, but I don't get why any notion
> of SR-IOV could be beneficial for virtio.
> 

Good point, I'll add a bit of motivation.

For SR-IOV, it is not unusual for PFs to excercise control over VFs.
There is interest in the community to include an interface to allow this
in the virtio spec, when the PF is a virtio device.  This is what this
patch does.




> >
> >For example, it might make sense to split creating/destroying
> >SIOV devices from the transport passing data from the guest - the
> >driver would then not negotiate VIRTIO_F_SR_IOV (which
> >then means auto-provisioning).
> >
> >This is out of RFC, since we have two commands which are useful
> >to discover supported group types (ATM can be none or SR-IOV).
> >
> >
> >Michael S. Tsirkin (10):
> >  virtio: document forward compatibility guarantees
> >  admin: introduce device group and related concepts
> >  admin: introduce group administration commands
> >  admin: introduce virtio admin virtqueues
> >  pci: add admin vq registers to virtio over pci
> >  mmio: document ADMIN_VQ as reserved
> >  ccw: document ADMIN_VQ as reserved
> >  admin: command list discovery
> >  admin: conformance clauses
> >  ccw: document more reserved features
> >
> > admin.tex        | 540 +++++++++++++++++++++++++++++++++++++++++++++++
> > content.tex      | 112 +++++++++-
> > introduction.tex |   3 +
> > 3 files changed, 653 insertions(+), 2 deletions(-)
> > create mode 100644 admin.tex
> >
> >-- 
> >MST
> >
> >
> >This publicly archived list offers a means to provide input to the
> >OASIS Virtual I/O Device (VIRTIO) TC.
> >
> >In order to verify user consent to the Feedback License terms and
> >to minimize spam in the list archive, subscription is required
> >before posting.
> >
> >Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> >Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> >List help: virtio-comment-help@lists.oasis-open.org
> >List archive: https://lists.oasis-open.org/archives/virtio-comment/
> >Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> >List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> >Committee: https://www.oasis-open.org/committees/virtio/
> >Join OASIS: https://www.oasis-open.org/join/
> >
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

