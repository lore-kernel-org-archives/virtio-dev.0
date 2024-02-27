Return-Path: <virtio-dev-return-14362-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511B0C5478C
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 09:02:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 9EBC6C6107
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 09:02:41 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 84971986531
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Feb 2024 09:02:41 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 6BADA9863B6; Tue, 27 Feb 2024 09:02:41 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5C7439863DE
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Feb 2024 09:02:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Osw8U546MxaX4u1xeKb5dg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709024557; x=1709629357;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlpacEWacryyrIlJZOoZ2EmsNR8IKw7FDvlRQtzIliY=;
        b=aHAs9MmuOCmIi4RrPyqNC5wSyVF0AsFIIwGIBSu4jE6L5sF9mSKpuj19IoCjRzstG0
         7vOv9oKxp9e2oZfOgWsDDRN+ZjMiWswZaaXAfncG8ZYNAj19PO0Q+jPjbe6ZdbfZ+/Wr
         +GLGHnXBbPYJslIXqse9DNhMdmuqF+4iY4qlNMiS8eVxmqhEK1nzmEtAqQV8RX5nMBt+
         vuBENmpA95SShyZjiO+ysg9OzgdTx8U90O6UUP55VOe9i663Qy1IPNS+G+aHNtxPrGKk
         YtmEpAqyrALnROXO67d0hFJhfM3p/9QE5xHFP3crJjlko/BobEDCYab5m6IluCxdn8sk
         xTjg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ZtiKbbswnV6TZsWA6WIlBO02PpyD7Dp+8hbHYOKlV5CBUbQjIQ3knbhiBfBGv/JlZk3Ypr4k58Kjr1wFtBbXAT3WFlleaSfUd1phKJDC
X-Gm-Message-State: AOJu0YygSvrB+ZonFpjBLOR7SCuLqZjyEla2UndoqalMCTkEc9YW2sIt
	EJFGBC8bMtu4dGn2dEPANsmPbIaw5mqS62LUmim/UFy/X5uIbVa2yc/hkzp9usbH8aqXeNPI7Nr
	gf09/fQzND0u7+5krazXT/lhQ8Bn98kVGhWenCG/APgCBk7jqRYZQjpqMr+gz2EsCaA==
X-Received: by 2002:ac8:7cb5:0:b0:42e:71bf:fb92 with SMTP id z21-20020ac87cb5000000b0042e71bffb92mr8237053qtv.40.1709024556884;
        Tue, 27 Feb 2024 01:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEktM+QuiKRjrNahkKKCp6g6mPsIdmLJBBljJdl/Jpj1OjlZw9vIz8CtyenrJ+CoAmXDtw3rw==
X-Received: by 2002:ac8:7cb5:0:b0:42e:71bf:fb92 with SMTP id z21-20020ac87cb5000000b0042e71bffb92mr8237041qtv.40.1709024556554;
        Tue, 27 Feb 2024 01:02:36 -0800 (PST)
Date: Tue, 27 Feb 2024 10:02:33 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Message-ID: <Zd2lKYLGT8ZEFzZd@fedora>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
 <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
 <ZdX3xgM36iOVhr3V@fedora>
 <20240221-juggling-uproar-9518b4901f41-mkl@pengutronix.de>
 <877circsh3.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <877circsh3.fsf@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can:
 Device specification.

On Mon, Feb 26, 2024 at 01:36:40PM +0100, Cornelia Huck wrote:
> On Wed, Feb 21 2024, Marc Kleine-Budde <mkl@pengutronix.de> wrote:
> 
> > On 21.02.2024 14:16:54, Matias Ezequiel Vara Larsen wrote:
> >> On Wed, Feb 21, 2024 at 01:49:31PM +0100, Marc Kleine-Budde wrote:
> >> > On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
> >> > > > > +The length of the \field{sdu} is determined by the \field{length}.
> >> > > > > +
> >> > > > > +The type of a CAN message identifier is determined by \field{flags}. The
> >> > > > > +3 most significant bits of \field{can_id} do not bear the information
> >> > > > > +about the type of the CAN message identifier and are 0.
> >> > > > > +
> >> > > > > +The device MUST reject any CAN frame type for which support has not been
> >> > > > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
> >> > > > > +schedule the message for transmission. A CAN frame with an undefined bit
> >> > > > > +set in \field{flags} is treated like a CAN frame for which support has
> >> > > > > +not been negotiated.
> >> > > > > +
> >> > > > > +The device MUST reject any CAN frame for which \field{can_id} or
> >> > > > > +\field{sdu} length are out of range or the CAN controller is in an
> >> > > > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
> >> > > > > +NOT schedule the message for transmission.
> >> > > > > +
> >> > > I am not very familiar with CAN but how does the device figure out that
> >> > > the can_id is out of range?
> >> > 
> >> > In classical CAN we have the standard CAN frames, which have an 11 bit
> >> > ID, and there are extended CAN frames, which have 29 bits ID. Extended
> >> > frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.
> >> > 
> >> > So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
> >> > out of range.
> >
> > Another option would be an extended frame (VIRTIO_CAN_FLAGS_EXTENDED
> > set) and using more than 29 bits.
> >
> >> Thanks Marc for the explanation. Do you think that it would be
> >> worthwhile to add that to the spec at some point?
> >
> > Yes that makes sense as it clarifies what's meant by out of range for
> > CAN-IDs, for the valid length a reference to
> > \item[VIRTIO_CAN_F_CAN_CLASSIC (0)] and \item[VIRTIO_CAN_F_CAN_FD (1)]
> > might be added.
> 
> [virtio mailing lists are supposedly down for migration right now, I
> hope there's some kind of backfill happening later...]
> 
> If the question comes up, it does make sense to add a
> clarification... as the virtio-can spec is already voted upon and
> merged, we'd need a patch on top. Not sure if it would qualify as an
> editorial update or a vote would be needed, best to see it first :)
> 
I will submit two patches regarding the changes proposed in this thread.

Matias


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

