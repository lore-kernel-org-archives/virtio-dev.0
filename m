Return-Path: <virtio-dev-return-11403-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C7AC6FA8E
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:43:23 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 6D85D44348
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:43:22 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 54597986712
	for <virtio-dev@archiver.kernel.org>; Thu,  2 Mar 2023 23:43:22 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 3D7E3984091; Thu,  2 Mar 2023 23:43:22 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-Id: <virtio-dev.lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2CFC09866AF
	for <virtio-dev@lists.oasis-open.org>; Thu,  2 Mar 2023 23:43:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: HN18_hqwP9GhMlAwz1maWQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677800598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1WKjjDFt6+mySWfY/0gaWPFeg8womcyZDSuMYhzN1tg=;
        b=OsecEzIUN3jXCQgPr3zaqVvCkv8d5I+OH1HbdV/rkazudyl6NfMkCyDzBAxv8tdBRl
         f1TtV9s0f57AzngxR6Tj+RvbAviEnncZzoJ8W9MpmmED8oe4eHSzAcIuKabeQF6UnuTP
         4QoLwCjAVUDS8S8Bb7S0MqhrOmlLVbm+eRo+wJr7tJAJWAEwr3bFPVYC2r8RP14z1dvM
         vtlmMgDUUdRa7qCqlaNpaP4szcsw5K+VB6GeoQZSxGtk4q/4bscCJFhFAVyTB/CZKp9K
         eIbi1gisYKFKMcqKF9NAvqZkB3TQbxmRanHsoknu+CPiE+65HQVndWNzd0eW/1yOgqCe
         BCAA==
X-Gm-Message-State: AO0yUKXDszhHjKTBCLLiePmF5mfVvWElzvOFBQcPkWMHyp3Su/CmU7N/
	vUq+G4IPemGURl2uzH/G6XYz5Je5iRIVkeY1kY7uUSDdODL8zKyAW0z1V8/UMOa/DmeUf6CzAl4
	ztUHJse7dLDyQ/Zy2hHqtvqkh8uAf
X-Received: by 2002:adf:cd10:0:b0:2c9:7ed3:6801 with SMTP id w16-20020adfcd10000000b002c97ed36801mr45863wrm.26.1677800598085;
        Thu, 02 Mar 2023 15:43:18 -0800 (PST)
X-Google-Smtp-Source: AK7set+n4fTJ2TD5eKbIb03edMTbmo1KmnOClWMM3Kc48kvvDSAylK/9mQAwjDAwshsSZs2PPzW2rQ==
X-Received: by 2002:adf:cd10:0:b0:2c9:7ed3:6801 with SMTP id w16-20020adfcd10000000b002c97ed36801mr45851wrm.26.1677800597694;
        Thu, 02 Mar 2023 15:43:17 -0800 (PST)
Date: Thu, 2 Mar 2023 18:43:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>,
	"Piotr.Uminski@intel.com" <Piotr.Uminski@intel.com>,
	"hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>,
	Zhu Lingshan <lingshan.zhu@intel.com>,
	"pasic@linux.ibm.com" <pasic@linux.ibm.com>,
	Shahaf Shuler <shahafs@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230302184301-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
 <PH0PR12MB54810807C3FB1E12BC5BF970DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54810807C3FB1E12BC5BF970DCB29@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v10 01/10] virtio: document forward compatibility
 guarantees

On Thu, Mar 02, 2023 at 06:39:29PM +0000, Parav Pandit wrote:
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Thursday, March 2, 2023 8:05 AM
> > 
> > Feature negotiation forms the basis of forward compatibility guarantees of
> > virtio but has never been properly documented.
> > Do it now.
> > 
> > Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> 
> It may be little painful, but in 10 patch series, it is worth having per patch change log.
> Because I do not know my reviewed by tag in [1] was dropped because of a big change, if so what was it or it was simply missed out.
> 
> [1] https://lists.oasis-open.org/archives/virtio-dev/202302/msg00237.html

I just lost it, no change.

> >  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> > 
> > diff --git a/content.tex b/content.tex
> > index 0e474dd..0c2d917 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a
> > Virtio Device / Feature B  In particular, new fields in the device configuration
> > space are  indicated by offering a new feature bit.
> > 
> > +To keep the feature negotiation mechanism extensible, it is important
> > +that devices \em{do not} offer any feature bits that they would not be
> > +able to handle if the driver accepted them (even though drivers are not
> > +supposed to accept them in the first place even if offered, according
> > +to this version of the specification.) Likewise, it is important that
> > +drivers \em{do not} accept feature bits they do not know how to handle
> > +(even though devices are not supposed to offer them in the first place,
> > +according to this version of the specification.) The preferred way for
> > +handling reserved and unexpected features is that the driver ignores
> > +them.
> > +
> > +In particular, this is
> > +especially important for features limited to specific transports, as
> > +enabling these for more transports in future versions of the
> > +specification is highly likely to require changing the behaviour from
> > +drivers and devices.  Drivers and devices supporting multiple
> > +transports need to carefully maintain per-transport lists of allowed
> > +features.
> > +
> >  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device /
> > Feature Bits}  The driver MUST NOT accept a feature which the device did not
> > offer,  and MUST NOT accept a feature which requires another feature which
> > was  not accepted.
> > 
> > +The driver MUST validate the feature bits offered by the device.
> > +The driver MUST ignore and MUST NOT accept any feature bit that is
> > +\begin{itemize} \item not described in this specification, \item marked
> > +as reserved, \item not supported for the specific transport, \item not
> > +defined for the device type.
> > +\end{itemize}
> > +
> >  The driver SHOULD go into backwards compatibility mode  if the device does
> The grammar tool is suggesting s/backwards/backward.
> 
> > not offer a feature it understands, otherwise MUST  set the FAILED \field{device
> > status} bit and cease initialization.
> > 
> > +By contrast, the driver MUST NOT fail solely because a feature it does
> > +not understand has been offered by the device.
> > +
> Above line can be written without introducing "has been" given we have only two entities (driver, dev) to care about.
> 
> By contrast, the driver MUST NOT fail solely because it does not understand the feature offered by the device.
> 
> >  \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device /
> > Feature Bits}  The device MUST NOT offer a feature which requires another
> > feature  which was not offered.  The device SHOULD accept any valid subset  of
> Extra white space between feature and which, subset and of.
> 
> > features the driver accepts, otherwise it MUST fail to set the  FEATURES_OK
> > \field{device status} bit when the driver writes it.
> > 
> Extra white space between the FEATURE_OK
> 
> > +The device MUST NOT offer feature bits corresponding to features it
> > +would not support if accepted by the driver (even if the driver is
> > +prohibited from accepting the feature bits by the specification); for
> > +the sake of clarity, this refers to feature bits not described in this
> > +specification, reserved feature bits and feature bits reserved or not
> > +supported for the specific transport or the specific device type, but
> > +this does not preclude devices written to a future version of this
> > +specification from offering such feature bits should such a
> > +specification have a provision for devices to support the corresponding
> > +features.
> > +
> >  If a device has successfully negotiated a set of features  at least once (by
> > accepting the FEATURES_OK \field{device  status} bit during device
> > initialization), then it SHOULD
> > --
> > MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

