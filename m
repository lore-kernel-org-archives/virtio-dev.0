Return-Path: <virtio-dev-return-12975-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE26BEB64D9
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:26:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 2D13B42C27
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:26:10 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 091FC986428
	for <virtio-dev@archiver.kernel.org>; Mon, 19 Jun 2023 17:26:10 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id E14EC9863A6; Mon, 19 Jun 2023 17:26:09 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id CEAE19863A9
	for <virtio-dev@lists.oasis-open.org>; Mon, 19 Jun 2023 17:26:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: H2O5hqZyOAGloqUle6-Twg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687195566; x=1689787566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlHTiR1qOBdA6C2/U49rcJbl2e8ybqaN8C3Cph0nxoQ=;
        b=OsgtjVajaahHZ0Rh0gEZGKi8CykXGS323gE3E8uPbXFccUk9HxmsdkqO0g9qc1cyp7
         YOhgZMwUoDNUNaHaKxobYecsp/ksMZfFRdSMZBkdZ6AL2sVlGVQeQy/Wu1xiJ0iE50+C
         lvmJODZ5D18ci/u+cZJGeR85wXSGDlo2TpzVNULKrdrvhhMUUSPBngyCozjyrwU7l/mP
         KcsGJrVA+jt3/i4i4E3n3Xx7laT6czb9cSAQ9P6nXHPL2po3QItOp6cYekcgEkEB4Pcw
         w9HWQIUysNuqIPV4uL37XWVTlrAZ2RCqJX607G6aeT0svAbCXiQNNYt8JInMdMi0AQf6
         NHyg==
X-Gm-Message-State: AC+VfDyWUOrwjSU1ic9132U4nQ2cVpxrKkJk1Q8LTgldE991DOPJiFNC
	1BVR9jSw6HwGJurzT1IF8OLwB4FX7QsWq3I1dc4j6S2knXpXUaRZ2z4X60B+lBm6oifvSgs0vya
	iXEvYVTf2muAmhpVERXvB72rtmh1C
X-Received: by 2002:a5d:67cd:0:b0:311:18d2:ff5c with SMTP id n13-20020a5d67cd000000b0031118d2ff5cmr8741262wrw.27.1687195566617;
        Mon, 19 Jun 2023 10:26:06 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5cWiNcJvpQnZmq0U0axOh3enBzGBS1X8fRFd9cqBZC1gZVhjRMAISicb2RG/Zd+OxwA5hniw==
X-Received: by 2002:a5d:67cd:0:b0:311:18d2:ff5c with SMTP id n13-20020a5d67cd000000b0031118d2ff5cmr8741242wrw.27.1687195566307;
        Mon, 19 Jun 2023 10:26:06 -0700 (PDT)
Date: Mon, 19 Jun 2023 13:26:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"cohuck@redhat.com" <cohuck@redhat.com>,
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"sburla@marvell.com" <sburla@marvell.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>,
	Shahaf Shuler <shahafs@nvidia.com>
Message-ID: <20230619132018-mutt-send-email-mst@kernel.org>
References: <20230613173015.1244486-1-parav@nvidia.com>
 <20230613173015.1244486-5-parav@nvidia.com>
 <20230619124042-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481506017B439B07FC1253DDC5FA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [virtio-dev] Re: [PATCH v6 4/4] transport-pci: Introduce group
 legacy group member config region access

On Mon, Jun 19, 2023 at 05:11:19PM +0000, Parav Pandit wrote:
> 
> 
> > From: virtio-dev@lists.oasis-open.org <virtio-dev@lists.oasis-open.org> On
> > Behalf Of Michael S. Tsirkin
> > Sent: Monday, June 19, 2023 1:04 PM
> 
> > On Tue, Jun 13, 2023 at 08:30:15PM +0300, Parav Pandit wrote:
> > > +Even though virtqueue driver notifications can be communicated
> > > +through administration virtqueue, if the group member device support
> > > +such notifications using a memory-mapped operation, such driver
> > > +notifications are sent using a group member device defined notification
> > region.
> > 
> > I still feel we should support sending notifications to owner at least optionally.
> > For example:
> >
> Let's not please keep discussing this yet again.
> I won't be able to.
> We have captured this alternative already in the cover letter in the alternatives section.
> 
> This optional capability can be added when there is a _real_ implementation by some hw.
>  
> > 
> > \begin{lstlisting}
> > struct virtio_pci_owner_legacy_notify_cap {
> >         struct virtio_pci_cap cap;
> >         le32 notify_off_multiplier; /* Multiplier for member id. */ }; \end{lstlisting}
> > 
> > \field{notify_off_multiplier} is combined with the \field{member id} to derive
> > an address within a BAR.
> > 
> > \begin{lstlisting}
> >         cap.offset + member_id * notify_off_multiplier \end{lstlisting}
> > 
> > 
> > 
> > We also need, as part of theory of operation, text that reads something like
> > "accessing the member device legacy interface using one of XYZ commands has
> > the same effect as accessing it using the legacy interface".
> > 
> Ack. I will add this.
> 
> > 
> > 
> > Also, do all VFs support legacy interface with these commands or none at all?
> >
> Right.
>  
> > 
> > Also these devices will use non-transitional ID but they in fact do have a legacy
> > interface so using this definition they are transitional devices. Maybe we need
> > to add when we describe the device ID text like "non transitional devices and
> > transitional devices utilizing commands XYZ" ...?
> 
> Transitional device has specific meaning, I am not sure we should muddy it.



To simplify transition from these earlier draft interfaces,
a device MAY implement:

\begin{description}
\item[Transitional Device]
        a device supporting both drivers conforming to this
        specification, and allowing legacy drivers.
\end{description}


I agree it can be read this way. The issue is a lot of text
in the spec just assumes that "has legacy interface == transitional
device".



For example:
When using the legacy interface the driver MAY access 
the device-specific configuration region using any width accesses, and
a transitional device MUST present driver with the same results as
when accessed using the ``natural'' access method (i.e.
32-bit accesses for 32-bit fields, etc).


If we break the assumption we need to audit the spec for this
assumption and again, I really would rather not.




-- 
MST


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

