Return-Path: <virtio-dev-return-11459-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53CE2C61DA4
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:00:31 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9891E44350
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:00:30 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8EDCE9866CC
	for <virtio-dev@archiver.kernel.org>; Mon,  6 Mar 2023 22:00:30 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 83EA9983C2D; Mon,  6 Mar 2023 22:00:30 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6FA8D9866BF
	for <virtio-dev@lists.oasis-open.org>; Mon,  6 Mar 2023 22:00:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 2u94gQlcNNKZa9G2c0MH_w-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678140022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhzVqHVcrHIyDRtyLxqjAOdIe18J6yPBs2WiqjSTruw=;
        b=SXvobOwlhD3HEqLH7lMvHYhsU1XyafVbqymEBnJC5NJos989h+k8fseL0zBFlKSkCu
         cn+Q43s/PsJL1Ycfm89GjmrHYS1oDMPz06inoOXPAXzdorNTNWyFiFJdEVrdJH0OxSo2
         d0T4ueAWca6+1kL609h4OtUpPqKU8krQ7/C77XE6H6PZEmkl/zuvt0Tr8V/z47GJltaf
         H2IKQDtggiKx4JgAMEcIGqPpkmRLr+jquJcDWHoZfQua04HSFWb1LVnj20e+W6sxnqGv
         sYfShe661ovebXopr0qx6w8InPOwOw7tbKxR/yZ8l2A6TuvCy4XB415fysWEzR3wd9Xy
         75LQ==
X-Gm-Message-State: AO0yUKW1sVcE3T2rJDdm2/0qseUb6d+hyqjdn4lImp3xvweJTSC0A1wP
	gzIsulgA0FA9VAhBIX1sghtPQ+zUMq+nuL/jfeIKttG32VTdaKghfhyNA+az6aXTvA5vfCSKH1T
	CDp/nsnbYp/lZVLH5g/aWiNUXQo0K
X-Received: by 2002:a05:600c:3153:b0:3eb:39c9:ecb0 with SMTP id h19-20020a05600c315300b003eb39c9ecb0mr10974695wmo.8.1678140021794;
        Mon, 06 Mar 2023 14:00:21 -0800 (PST)
X-Google-Smtp-Source: AK7set8ZpG0ST+1T1wypzMJip+v14GvHhEWpDkTiobInbREotsd9T68tRJTOuSaGg0jjaap43RCakQ==
X-Received: by 2002:a05:600c:3153:b0:3eb:39c9:ecb0 with SMTP id h19-20020a05600c315300b003eb39c9ecb0mr10974668wmo.8.1678140021446;
        Mon, 06 Mar 2023 14:00:21 -0800 (PST)
Date: Mon, 6 Mar 2023 17:00:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Edmondson <david.edmondson@oracle.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org,
	jasowang@redhat.com, cohuck@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, nrupal.jani@intel.com, Piotr.Uminski@intel.com,
	hang.yuan@intel.com, virtio@lists.oasis-open.org,
	Zhu Lingshan <lingshan.zhu@intel.com>, pasic@linux.ibm.com,
	Shahaf Shuler <shahafs@nvidia.com>, Parav Pandit <parav@nvidia.com>,
	Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <20230306165907-mutt-send-email-mst@kernel.org>
References: <cover.1677761896.git.mst@redhat.com>
 <0a784140387c2a592f7e1e7bbc5ae926ec5b45da.1677761896.git.mst@redhat.com>
 <m2leka0yvl.fsf@oracle.com>
MIME-Version: 1.0
In-Reply-To: <m2leka0yvl.fsf@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio] [PATCH v10 01/10] virtio: document forward
 compatibility guarantees

On Mon, Mar 06, 2023 at 01:53:50PM +0000, David Edmondson wrote:
> "Michael S. Tsirkin" <mst@redhat.com> writes:
> 
> > Feature negotiation forms the basis of forward compatibility
> > guarantees of virtio but has never been properly documented.
> > Do it now.
> >
> > Suggested-by: Halil Pasic <pasic@linux.ibm.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  content.tex | 42 ++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 42 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 0e474dd..0c2d917 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -114,21 +114,63 @@ \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device / Feature B
> >  In particular, new fields in the device configuration space are
> >  indicated by offering a new feature bit.
> >  
> > +To keep the feature negotiation mechanism extensible, it is important
> > +that devices \em{do not} offer any feature bits that they would not be
> > +able to handle if the driver accepted them (even though drivers are not
> > +supposed to accept them in the first place even if offered, according to
> > +this version of the specification.) 
> 
> I find this (the bit in parenthesis) confusing.
> 
> Why are drivers not supposed to accept features that they have been
> offered, given that they can't know that the device cannot handle the
> feature that it just offered?
> 
> Is this alluding to the later section:
> 
> > feature bits not described in this specification, reserved feature
> > bits and feature bits reserved or not supported for the specific
> > transport or the specific device type
> 
> ?

exactly. how would you put this better? given an example?

> > Likewise, it is important that
> > +drivers \em{do not} accept feature bits they do not know how to handle
> > +(even though devices are not supposed to offer them in the first place,
> > +according to this version of the specification.) The preferred way for
> > +handling reserved and unexpected features is that the driver ignores
> > +them.
> > +
> > +In particular, this is
> > +especially important for features limited to specific transports,
> > +as enabling these for more transports in future versions of the
> > +specification is highly likely to require changing the behaviour
> > +from drivers and devices.
> 
> "require changed behaviour from drivers and devices".
> 
> > Drivers and devices supporting
> > +multiple transports need to carefully maintain per-transport
> > +lists of allowed features.
> > +
> >  \drivernormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
> >  The driver MUST NOT accept a feature which the device did not offer,
> >  and MUST NOT accept a feature which requires another feature which was
> >  not accepted.
> >  
> > +The driver MUST validate the feature bits offered by the device.
> > +The driver MUST ignore and MUST NOT accept any feature bit that is
> > +\begin{itemize}
> > +\item not described in this specification,
> > +\item marked as reserved,
> > +\item not supported for the specific transport,
> > +\item not defined for the device type.
> > +\end{itemize}
> > +
> >  The driver SHOULD go into backwards compatibility mode
> >  if the device does not offer a feature it understands, otherwise MUST
> >  set the FAILED \field{device status} bit and cease initialization.
> >  
> > +By contrast, the driver MUST NOT fail solely because a feature
> > +it does not understand has been offered by the device.
> > +
> >  \devicenormative{\subsection}{Feature Bits}{Basic Facilities of a Virtio Device / Feature Bits}
> >  The device MUST NOT offer a feature which requires another feature
> >  which was not offered.  The device SHOULD accept any valid subset
> >  of features the driver accepts, otherwise it MUST fail to set the
> >  FEATURES_OK \field{device status} bit when the driver writes it.
> >  
> > +The device MUST NOT offer feature bits corresponding to features
> > +it would not support if accepted by the driver (even if the
> > +driver is prohibited from accepting the feature bits by the
> > +specification); for the sake of clarity, this refers to feature
> > +bits not described in this specification, reserved feature bits
> > +and feature bits reserved or not supported for the specific
> > +transport or the specific device type, but this does not preclude
> > +devices written to a future version of this specification from
> > +offering such feature bits should such a specification have a
> > +provision for devices to support the corresponding features.
> > +
> >  If a device has successfully negotiated a set of features
> >  at least once (by accepting the FEATURES_OK \field{device
> >  status} bit during device initialization), then it SHOULD
> > -- 
> > MST
> >
> >
> > ---------------------------------------------------------------------
> > To unsubscribe from this mail list, you must leave the OASIS TC that 
> > generates this mail.  Follow this link to all your TCs in OASIS at:
> > https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

