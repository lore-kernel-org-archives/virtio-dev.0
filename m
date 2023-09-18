Return-Path: <virtio-dev-return-13806-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7ED94C46CA1
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 17:30:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id C14F4C6109
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 17:30:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id A387E98642C
	for <virtio-dev@archiver.kernel.org>; Mon, 18 Sep 2023 17:30:43 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 8EDFF9863D8; Mon, 18 Sep 2023 17:30:43 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7E22098640C
	for <virtio-dev@lists.oasis-open.org>; Mon, 18 Sep 2023 17:30:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: gobnMSxMOo-KocF-YsK60g-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695058239; x=1695663039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CnlUS9cQBdroapA8xyJQIGp1RfJxTW8/aQMePaiokE0=;
        b=MBqT4aqC0oBAfICZ+9GFCg+IgXn3j4LNeh99rG7k6kJ2C4SCJqM79ut95/FAw0kNvc
         CGS95et9T7d5r2/5qmqEoVZdouvXmistDZ6g0daTDeyvAzgmFlznmEBIyoVg/aDRzxGX
         gZdXqDHEBb2/zO3XsF68iuYq95EpUczZyGH2ymnD/RjvUeyz9sD2vNQuC3M0rQSwsrvv
         5MM2gAquqZm6Z4yJHsj5Kd3djbcQqQJU6JB4Dkn2jKg+i/3URIfcG3NTcGnZ36iMre3Z
         rsYz7j7jf0eT8ryefYEAMk33bCXVKiy3ksRPx65SGxDJt7gIv/r9QJcT/VPvod3wORZ7
         y/ZQ==
X-Gm-Message-State: AOJu0Yw02kTadivb9wel5rByBplNcJBzjQHy7aT3Bmj7dVtQoUzyVfya
	L79X0vKrb5BQj/CCBdHP1rX5zEjqY2v914oMcsa5YEqIckzYWD9zufGPG55pjHBgrMVJ44vfiOR
	EykHju0IfOU+3oJxxGUnviCnUMqXc
X-Received: by 2002:a05:6512:545:b0:502:bdbd:8442 with SMTP id h5-20020a056512054500b00502bdbd8442mr7582417lfl.50.1695058238943;
        Mon, 18 Sep 2023 10:30:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHbngeJ/ftAJXHwtTZZ8tAxdw6HYfM2Bwfj3KACS9ZwnEqWtVWqDxHuvKks6/dFJmtbp4akAg==
X-Received: by 2002:a05:6512:545:b0:502:bdbd:8442 with SMTP id h5-20020a056512054500b00502bdbd8442mr7582401lfl.50.1695058238511;
        Mon, 18 Sep 2023 10:30:38 -0700 (PDT)
Date: Mon, 18 Sep 2023 13:30:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: jasowang@redhat.com, eperezma@redhat.com, cohuck@redhat.com,
	stefanha@redhat.com, virtio-comment@lists.oasis-open.org,
	virtio-dev@lists.oasis-open.org
Message-ID: <20230918132852-mutt-send-email-mst@kernel.org>
References: <20230906081637.32185-1-lingshan.zhu@intel.com>
 <20230906081637.32185-4-lingshan.zhu@intel.com>
 <20230914072857-mutt-send-email-mst@kernel.org>
 <313a60c5-34ac-ca77-b7e1-7cb7eaf11340@intel.com>
 <20230915071111-mutt-send-email-mst@kernel.org>
 <547e4395-4244-290d-9d6e-1de02d1e7e71@intel.com>
MIME-Version: 1.0
In-Reply-To: <547e4395-4244-290d-9d6e-1de02d1e7e71@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH 3/5] virtqueue: constraints for
 virtqueue state

On Mon, Sep 18, 2023 at 11:02:18AM +0800, Zhu, Lingshan wrote:
> 
> 
> On 9/15/2023 7:16 PM, Michael S. Tsirkin wrote:
> > On Fri, Sep 15, 2023 at 10:59:29AM +0800, Zhu, Lingshan wrote:
> > > 
> > > On 9/14/2023 7:30 PM, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 06, 2023 at 04:16:35PM +0800, Zhu Lingshan wrote:
> > > > > This commit specifies the constraints of the virtqueue state,
> > > > > and the actions should be taken by the device when SUSPEND
> > > > > and DRIVER_OK is set
> > > > > 
> > > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > > > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > > > > Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> > > > > ---
> > > > >    content.tex | 19 +++++++++++++++++++
> > > > >    1 file changed, 19 insertions(+)
> > > > > 
> > > > > diff --git a/content.tex b/content.tex
> > > > > index 0fab537..9d727ce 100644
> > > > > --- a/content.tex
> > > > > +++ b/content.tex
> > > > > @@ -594,6 +594,25 @@ \subsection{\field{Used State} Field}
> > > > >    When VIRTIO_RING_F_PACKED is not negotiated, the 16-bit value of \field{used_idx}
> > > > >    is always 0
> > > > > +\drivernormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
> > > > > +
> > > > > +If VIRTIO_F_QUEUE_STATE has been negotiated but VIRTIO_RING_F_PACKED not been negotiated,
> > > > > +the driver SHOULD NOT access \field{Used State} of any virtqueues, it SHOULD use the
> > > > > +used index in the used ring.
> > > > > +
> > > > > +\devicenormative{\subsection}{Virtqueue State}{Basic Facilities of a Virtio Device / Virtqueue State}
> > > > > +
> > > > > +If VIRTIO_F_QUEUE_STATE has been negotiated, the device SHOULD only accept setting
> > > > > +Virtqueue State of any virtqueues when DRIVER_OK is not set in \field{device status},
> > > > > +or both of DRIVER_OK and SUSPEND are set in \field{device status}.
> > > > > +Otherwise the device MUST ignore any writes to Virtqueue State of any virtqueues.
> > > > > +
> > > > > +If VIRTIO_F_QUEUE_STATE have been negotiated, when SUSPEND is set,
> > > > > +the device MUST record the Virtqueue State of every enabled virtqueue
> > > > > +in \field{Available State} and \field{Used State} respectively,
> > > > record how?
> > > This is transport specific, for PCI they are recorded in the common config
> > > space,
> > > two new fields of them are introduced in patch 5.
> > 
> > that is not enough space to record state for every enabled vq.
> They can work with queue_select like many other vq configurations.

queue select is under driver control.


> I will mention this in the comment.
> > 
> > > > > +and correspondingly restore the Virtqueue State of every enabled virtqueue
> > > > > +from \field{Available State} and \field{Used State} when DRIVER_OK is set.
> > > > when is that?
> > > When the DRIVER sets DRIVER_OK and done before the device presents
> > > DRIVER_OK.
> > I don't really understand the flow here. does SUSPEND clear DRIVER_OK
> > then?
> SUSPEND does not clear DRIVER, I think this is not a must.

then I don't get what does "when DRIVER_OK is set" mean - it stays
set all the time.


> > 
> > 
> > > > 
> > > > > +
> > > > >    \input{admin.tex}
> > > > >    \chapter{General Initialization And Device Operation}\label{sec:General Initialization And Device Operation}
> > > > > -- 
> > > > > 2.35.3
> > 
> > This publicly archived list offers a means to provide input to the
> > OASIS Virtual I/O Device (VIRTIO) TC.
> > 
> > In order to verify user consent to the Feedback License terms and
> > to minimize spam in the list archive, subscription is required
> > before posting.
> > 
> > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > List help: virtio-comment-help@lists.oasis-open.org
> > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> > 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

