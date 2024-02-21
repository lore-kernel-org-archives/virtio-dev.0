Return-Path: <virtio-dev-return-14343-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA4E3C48BC3
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Feb 2024 13:17:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2C1732AC9B
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Feb 2024 13:17:05 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 236D798654C
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Feb 2024 13:17:05 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 11E7C9864F2; Wed, 21 Feb 2024 13:17:05 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 0220A9864B0
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Feb 2024 13:17:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: Nmlsrk4GMxG5ae6AIk3oIg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708521417; x=1709126217;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/w1WDwOHGakhJUAR/C6JZj5tsVNs/vIQZ9PZvXihR0=;
        b=sfaVtXQbhB7MbUHHj41UvQdrDnewOYyBChsYrjq+zzEjhyiLtpnfCA59LNzlVujF/J
         uLz1jIKfk3dZ4KXfmwfoEHuPQSGQfCgAb0a0sThW99ZP+b5GJ1emBUA+U0GuXjLDySs7
         rFEZHX74umo3DGJbAu66dcEJAEgLO+o4P7MBqL5to0KVAo7PJ07TTJ3Ae3z6TWUruYNQ
         7ZPB7SY3KW9lB1tZLaBUePhm8ePOoqSN5rqOZrhJ0cROgU8luhZzntTderE6BtJ8trPD
         xeG/teIRSyxmUP0koAuhTgnojygKDfST7xVcba1N8uP3Ie4Hny/VzTpEefNSQPu68cJO
         D8yQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7pfMshA/bTPWr4AWpiOYrVl6mToiAAKpZXg5lDFwr1iq7vP/4ueh1M9uqGAJ+hDhtehS10xytOfjJNDiq6Zt9RbUSSAsH9oSWWmr9q0cm
X-Gm-Message-State: AOJu0YxWeFatcJBPVsThNjjEe+vMtdF2gnq4pep4pB2/GonsCZV7pJvb
	0SyVWDJd8NO3XrkqlF0f1bnv9tr80Z1ufNJ2rVSRR/y2+E1bg1x1/8gKzWU6WaJxdehJ1o9Tsot
	vGGUONMnqgJGlfiYuskhTxsU5nMp/EtwqsqBCAQHMlhYas0DDkChFaYcsaC/DrFr0OA==
X-Received: by 2002:a2e:9858:0:b0:2d2:31f4:35c with SMTP id e24-20020a2e9858000000b002d231f4035cmr6596914ljj.25.1708521417002;
        Wed, 21 Feb 2024 05:16:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqTrtmtAQXm6a084V0K36E+nFmsfirlA7sHCUWcc7J24nFFUapF0/gtS/pp7AUV6Fb2PWRSQ==
X-Received: by 2002:a2e:9858:0:b0:2d2:31f4:35c with SMTP id e24-20020a2e9858000000b002d231f4035cmr6596894ljj.25.1708521416595;
        Wed, 21 Feb 2024 05:16:56 -0800 (PST)
Date: Wed, 21 Feb 2024 14:16:54 +0100
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Mikhail Golubev-Ciuchea <mikhail.golubev-ciuchea@opensynergy.com>,
	virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org, linux-can@vger.kernel.org,
	Harald Mommer <harald.mommer@opensynergy.com>
Message-ID: <ZdX3xgM36iOVhr3V@fedora>
References: <20230609142243.199074-1-Mikhail.Golubev-Ciuchea@opensynergy.com>
 <ebc57e36-d822-4264-a763-b530482b2669@opensynergy.com>
 <ZdXShopKyMYPTUva@fedora>
 <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
MIME-Version: 1.0
In-Reply-To: <20240221-acts-decade-76d3d69e8e4d-mkl@pengutronix.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [virtio-comment] [RFC PATCH v3] virtio-can:
 Device specification.

On Wed, Feb 21, 2024 at 01:49:31PM +0100, Marc Kleine-Budde wrote:
> On 21.02.2024 11:37:58, Matias Ezequiel Vara Larsen wrote:
> > > > +The length of the \field{sdu} is determined by the \field{length}.
> > > > +
> > > > +The type of a CAN message identifier is determined by \field{flags}. The
> > > > +3 most significant bits of \field{can_id} do not bear the information
> > > > +about the type of the CAN message identifier and are 0.
> > > > +
> > > > +The device MUST reject any CAN frame type for which support has not been
> > > > +negotiated with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST NOT
> > > > +schedule the message for transmission. A CAN frame with an undefined bit
> > > > +set in \field{flags} is treated like a CAN frame for which support has
> > > > +not been negotiated.
> > > > +
> > > > +The device MUST reject any CAN frame for which \field{can_id} or
> > > > +\field{sdu} length are out of range or the CAN controller is in an
> > > > +invalid state with VIRTIO_CAN_RESULT_NOT_OK in \field{result} and MUST
> > > > +NOT schedule the message for transmission.
> > > > +
> > I am not very familiar with CAN but how does the device figure out that
> > the can_id is out of range?
> 
> In classical CAN we have the standard CAN frames, which have an 11 bit
> ID, and there are extended CAN frames, which have 29 bits ID. Extended
> frames are signaled with VIRTIO_CAN_FLAGS_EXTENDED set.
> 
> So if a standard frame uses more than 11 Bits of CAN-ID, it's considered
> out of range.
> 
Thanks Marc for the explanation. Do you think that it would be
worthwhile to add that to the spec at some point?

Matias.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

