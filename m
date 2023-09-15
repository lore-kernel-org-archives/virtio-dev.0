Return-Path: <virtio-dev-return-13776-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EE7FEE645B
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 11:16:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id BE2D22A880
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 11:16:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id ADC3F986667
	for <virtio-dev@archiver.kernel.org>; Fri, 15 Sep 2023 11:16:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 9FB03984033; Fri, 15 Sep 2023 11:16:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9221D986659
	for <virtio-dev@lists.oasis-open.org>; Fri, 15 Sep 2023 11:16:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: xzhd68-SNAuWvUOkNKiCJw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694776568; x=1695381368;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMiGcLDXUsgh2I9plU4Gk16waQyZ+MZETGRJx6ZET40=;
        b=Wlrirb+za8GjeAozGHHtl3jCXh6LDDZ3odU4P36G9sQoSwvb5cRnEsJnD12HHHVuxn
         JNZe2N/IYpgSQww7DkIEz9Sb4PZKVtUnMmSahL+0b7tHwsVOIlWKs2k0gnNHuIT4e5fC
         E3X1USeEAkLDxemBc31VD4RZAtoCpCbbv/6USvhVJffYpFvvU+b+QN3evfX22fal+WE2
         4QcEoRgfycs6dMJvzKAz7yk8rfGE1NFUAyTs+9BZlV4wfiEBAk9uUpst7D427KYZyNHU
         Wu5e65kFZIrB3hr97vbO0rDX3hO9p2+lzQi02JbSOVyPnEEIo700IY78w70fZrOGvCfX
         tTJQ==
X-Gm-Message-State: AOJu0YzSgDDEJ0//fiEwVaOMelFqR4MGewsxK4C7TXFeRb7yy5ZJOBFn
	14Hll2hHGA0XrLAa6vBw98/pGvlREj77JdLLU4uC05/Nd1uxNdTbs0PI1LOyMVjKRc6wor08fO0
	bovSF6k7yXqhcAPmJODDFtQVvyt/j
X-Received: by 2002:a17:907:c27:b0:9ad:8641:e91b with SMTP id ga39-20020a1709070c2700b009ad8641e91bmr7096188ejc.11.1694776568651;
        Fri, 15 Sep 2023 04:16:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxtz+lBuunaIAxkQb4gR7XOJnU15d5EkkuY5Pe+JsdSrUUN5shCguMNYhgDwxDFUunXsFEdQ==
X-Received: by 2002:a17:907:c27:b0:9ad:8641:e91b with SMTP id ga39-20020a1709070c2700b009ad8641e91bmr7096156ejc.11.1694776568329;
        Fri, 15 Sep 2023 04:16:08 -0700 (PDT)
Date: Fri, 15 Sep 2023 07:16:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230915071111-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-4-lingshan.zhu@intel.com>
 <20230914072857-mutt-send-email-mst@kernel.org>
 <313a60c5-34ac-ca77-b7e1-7cb7eaf11340@intel.com>
MIME-Version: 1.0
In-Reply-To: <313a60c5-34ac-ca77-b7e1-7cb7eaf11340@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [PATCH 3/5] virtqueue: constraints for virtqueue state

On Fri, Sep 15, 2023 at 10:59:29AM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/14/2023 7:30 PM, Michael S. Tsirkin wrote:
> > On Wed, Sep 06, 2023 at 04:16:35PM +0800, Zhu Lingshan wrote:
> > > This commit specifies the constraints of the virtqueue state,
> > > and the actions should be taken by the device when SUSPEND
> > > and DRIVER_OK is set
> > > 
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > ---
> > >   content.tex | 19 +++++++++++++++++++
> > >   1 file changed, 19 insertions(+)
> > > 
> > > diff --git a/content.tex b/content.tex
> > > index 0fab537..9d727ce 100644
> > > --- a/content.tex
> > > +++ b/content.tex
> > > @@ -594,6 +594,25 @@ \subsection{\field{Used State} Field}
> > >   When VIRTIO_RING_F_PACKED is not negotiated, the 16-bit value of \field{used_idx}
> > >   is always 0
> > > +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
> > > +
> > > +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED not been negotiated,
> > > +the driver SHOULD NOT access \field{Used State} of any virtqueues, it SHOULD use the
> > > +used index in the used ring.
> > > +
> > > +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
> > > +
> > > +If VIRTIO_F_QUEUE_STATE has been negotiated, the device SHOULD only accept setting
> > > +Virtqueue State of any virtqueues when DRIVER_OK is not set in \field{device status},
> > > +or both of DRIVER_OK and SUSPEND are set in \field{device status}.
> > > +Otherwise the device MUST ignore any writes to Virtqueue State of any virtqueues.
> > > +
> > > +If VIRTIO_F_QUEUE_STATE have been negotiated, when SUSPEND is set,
> > > +the device MUST record the Virtqueue State of every enabled virtqueue
> > > +in \field{Available State} and \field{Used State} respectively,
> > record how?
> This is transport specific, for PCI they are recorded in the common config
> space,
> two new fields of them are introduced in patch 5.


that is not enough space to record state for every enabled vq.

> > 
> > > +and correspondingly restore the Virtqueue State of every enabled virtqueue
> > > +from \field{Available State} and \field{Used State} when DRIVER_OK is set.
> > when is that?
> When the DRIVER sets DRIVER_OK and done before the device presents
> DRIVER_OK.

I don't really understand the flow here. does SUSPEND clear DRIVER_OK
then?


> > 
> > 
> > > +
> > >   \input{admin.tex}
> > >   \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> > > -- 
> > > 2.35.3


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

