Return-Path: <virtio-dev-return-11420-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F4FC64EC4
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:20:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id DDDD62B06D
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:20:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CC9F39867B0
	for <virtio-dev@archiver.kernel.org>; Fri,  3 Mar 2023 13:20:29 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id BF2F99867A1; Fri,  3 Mar 2023 13:20:29 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 753559867A4
	for <virtio-dev@lists.oasis-open.org>; Fri,  3 Mar 2023 13:20:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: okgnuAp5PLeochiN6oV_FQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677849597;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeDOklAu1x5nMc/bRNtfzZYijWQE4sQKE/qI3bxqb9E=;
        b=rUCU0Ff3AmOhDn3/omQF1eywoifTRHRdee5m0tjdc4b7gZVE93WL2dpu/Ncq6JyT7o
         aJOgowCtQLz3OFVZeyA/qAbEZDq1eYZvDtuttKa3BlPPeTHPPxaltNBKZtbPT0m3TCwI
         iDnlR20DVZw0KZ5WxBIhmPWj6OUVEcFaae2qUV6RApFeqw3NQBrvEqCe64flngXuXJPS
         eMNJ5e3Rq1gPIpuYT4SMyAE1lrr2dhGQD+bVfPyMt5sl+6PSzEqpiAdc+NyL1xokw2rh
         rc5TgoOFMB3Ev4Bm9nBymhkasnUoO99l5abA12qtDnKEBRcgK5V+pQbMDs2y+CgGZ9eF
         nacw==
X-Gm-Message-State: AO0yUKWwRWcaWFO5dDd2okZ0GFlclobOPzbOVEBxKJ5dK2RTSsOkdnyk
	1q8V+oo60HBdqn3/O3hnMnYCYLit2iwJ10HJEScfPsY8SPCzba+svkakX6UYDJvCh+RgrER0f37
	dKY0ucfA9/9b4YNZEJGaUsCzVAyy6
X-Received: by 2002:adf:e6c9:0:b0:2cb:2775:6e6 with SMTP id y9-20020adfe6c9000000b002cb277506e6mr1278486wrm.45.1677849597496;
        Fri, 03 Mar 2023 05:19:57 -0800 (PST)
X-Google-Smtp-Source: AK7set9NHl0HIalXP+etinOwst7AHMBOhn+JVwQQGPOnXWikx3n74lICADIchJoSwxzJTahnxLchdA==
X-Received: by 2002:adf:e6c9:0:b0:2cb:2775:6e6 with SMTP id y9-20020adfe6c9000000b002cb277506e6mr1278471wrm.45.1677849597206;
        Fri, 03 Mar 2023 05:19:57 -0800 (PST)
Date: Fri, 3 Mar 2023 08:19:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230303081900-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <910b3607a5f255134d30b3e1233e564f564eafb8.1677761896.git.mst@redhat.com>
 <PH0PR12MB548116853CAC23DF9CA7345EDCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
 <20230302201912.GC2554028@fedora>
 <20230302185803-mutt-send-email-mst@kernel.org>
 <20230303131703.GB2866370@fedora>
MIME-Version: 1.0
In-Reply-To: <20230303131703.GB2866370@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 03/10] admin: introduce group administration commands

On Fri, Mar 03, 2023 at 08:17:03AM -0500, Stefan Hajnoczi wrote:
> On Thu, Mar 02, 2023 at 07:01:56PM -0500, Michael S. Tsirkin wrote:
> > On Thu, Mar 02, 2023 at 03:19:12PM -0500, Stefan Hajnoczi wrote:
> > > On Thu, Mar 02, 2023 at 06:40:29PM +0000, Parav Pandit wrote:
> > > > 
> > > > > From: Michael S. Tsirkin <mst@redhat.com>
> > > > > Sent: Thursday, March 2, 2023 8:05 AM
> > > > 
> > > > > +When \field{status} is VIRTIO_ADMIN_STATUS_OK, \field{status_qialifier}
> > > > > +is reserved and set to zero by the device.
> > > > > +
> > > > s/status_qialifier/status_qualifier
> > > > Missed from v10 of Feb.
> > > > 
> > > > > +When \field{status} is VIRTIO_ADMIN_STATUS_EINVAL, the following table
> > > > > +describes possible \field{status_qialifier} values:
> > > > s/status_qialifier/status_qualifier
> > > > 
> > > > Can you please add other useful error codes in addition to the EINVAL?
> > > > Few that we are needed EAGAIN, ENOMEM, EBUSY, ENODEV.
> > > 
> > > Please define a unique constant for each error condition that can occur
> > > instead of sharing catch-all errno constants between multiple error
> > > conditions. If a driver wants to squash them together into an errno,
> > > that's fine, but I think doing this at the hardware interface level is
> > > just propagating the mistakes of errnos.
> > > 
> > > Only status_qualifier is needed and the vague status field can be
> > > dropped. It's not clear to me why adding EAGAIN, ENOMEM, EBUSY, and
> > > ENODEV is useful. They have no meaning to the driver, only the
> > > status_qualifier really indicates what is going on.
> > 
> > At a high level at the moment we have only two cases:
> > - ok
> > - invalid input supplied by driver
> > 
> > maybe we will have more reasons for a failure - remains to
> > be seen.
> > 
> > 
> > 
> > 
> > 
> > > 
> > > I'm sure you guys have discussed this previously, but please provide
> > > rationale in the spec because it looks weird to someone with fresh eyes.
> > > 
> > > Stefan
> > 
> > Really most drivers just want to propagate errno to userspace.
> > All the detailed reporting is for sure well intentional but
> > in the end it is at best printed into log - end to end
> > people just end up with a switch statement
> > converting these to errno codes.
> > So we are passing them from device and this way there will be
> > some uniformity.
> 
> Please clarify the rationale in the spec. I don't agree with it, as
> explained in my earlier email, but as long as its documented, people can
> try to follow it.
> 
> Stefan

It's 2:2 for now, you are with Parav, me and Cornelia like it :)
Or I will try to document it better.

-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

