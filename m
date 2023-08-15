Return-Path: <virtio-dev-return-13531-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BA2C001E0
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 01:38:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 0899B23D52
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 01:38:48 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E8CDA986371
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 01:38:47 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id D12E8983C28; Tue, 15 Aug 2023 01:38:47 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id BF27498634B
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Aug 2023 01:38:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: 6jXEL9s8Oh6AHHTmETOJDA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692063524; x=1692668324;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6X6Zb92sijM7MGNlcqcppHV0YDc+NdT7XbBIZdFKrqQ=;
        b=MXwHap/RON9Nb/Bzlm5L4+DgxamkHXlsobMFXnKg2PXMN+LkTdNVKo7LOir6aoGeY+
         AysNs5c+4yEhjVezHZur1xWs6W3+a+F8WP+R18CVBzAx+rfZJO6hgBxF71StJSbDglKb
         PHYH21kGdMbQ0PKF+45qtjtvyx3ya6AG+DcKRJBInCiRZix+36Qg7bp3QiRnIGIoAub1
         f1/BVYdRPkHxVZRTKK//ZbdMZBTqa4XdpZaUdFnqUkeEkp9hh8JmJvCmSe/z6nWuiiRp
         fVmy53hA+IdHXV+tKljBmspnViUORP9+Zyhh0ZOoZXC6SzhIGd+XLUZAxlr+ohbIo14v
         u0QA==
X-Gm-Message-State: AOJu0Yx6J083SIXaGN+9n6kJqKUFYWRa8D6CC40FOTT6FNUWe/SXMdbz
	INmyEWlMkjWLtiy2LlmL5VcSOVEBO6y4E4YMs/HBVI4Xs4MgQedYDAFbRT+petXSLoOBLITG5Vs
	SRdONsYw0ZSuYAQfoxEVbB+5drUaGxv7G3FuOdZGRsNL3
X-Received: by 2002:a2e:9c18:0:b0:2af:25cf:92ae with SMTP id s24-20020a2e9c18000000b002af25cf92aemr8181297lji.22.1692063524210;
        Mon, 14 Aug 2023 18:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnrEiI0kOpdi1vmSd9tC2iZh4+bpL7RxJ0R0irfM4cpR4+w/BMlDgIMf3fPJWmIAh5r/+JjZW4ac3D8PbFvCg=
X-Received: by 2002:a2e:9c18:0:b0:2af:25cf:92ae with SMTP id
 s24-20020a2e9c18000000b002af25cf92aemr8181286lji.22.1692063523890; Mon, 14
 Aug 2023 18:38:43 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com> <20230814154717.GI3146793@fedora>
In-Reply-To: <20230814154717.GI3146793@fedora>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 09:38:33 +0800
Message-ID: <CACGkMEs=bM_M42q1wThxg8LV_+kYiO_-EC3Os7oUp5uJa9jFcw@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com, eperezma@redhat.com, 
	cohuck@redhat.com, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH 0/5] virtio: introduce SUSPEND bit
 and vq state

On Tue, Aug 15, 2023 at 12:28=E2=80=AFAM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
>
> On Tue, Aug 15, 2023 at 03:28:59AM +0800, Zhu Lingshan wrote:
> > This seires introduces
> > 1)a new SUSPEND bit in the device status
> > Which is used to suspend the device, so that the device states
> > and virtqueue states are stablized.
> >
> > 2)virtqueue state and accessors, to get and set last_avail_idx
> > and last_used_idx of virtqueues.
> >
> > The main usecase of these new facilities is Live Migration.
> >
> > Furture work: dirty page tracking and in-flight descriptors.
> >
> > This is RFC, this series carries on Jason and Eugenio's pervious work.
> >
> > Any comments are welcome.
>
> In order to support stateful devices like virtiofs, virtio-gpu, or
> virtio-crypto it would be necessary to add device state save/load
> functionality too.

+1 and before save/load, we need to define those states first.

E.g there are patches that try to fix the GPU suspend/hibernation
which probably requires those facilities as well.

>
> Even virtio-net needs device state save/load functionality if the VMM is
> not intercepting the stateful controlq.

Yes, this could be done via trap and emulation.

>
> In-flight descriptors can be included in the device state.
>

Probably.

> In fact, the only reason why I think VIRTIO_F_QUEUE_STATE makes sense is
> for easy integration into existing vhost software stacks. Otherwise we
> should just define a device state save/load interface along with
> standard device state serialization for devices where migration
> interoperability is possible. VIRTIO_F_QUEUE_STATE is a small subset of
> device state save/load.

For simple devices like virtio-net, queue state should be sufficient
for hardware.

>
> I think the convenience of integrating into existing vhost software
> stacks is worth the duplication, but I wanted to mention that this
> interface will not be enough to live migrate all device types and we'll
> need something more in the future.

Yes, the patch is a start for simple stateless devices.

Thanks

>
> Stefan
>
> >
> > Zhu Lingshan (5):
> >   virtio: introduce SUSPEND bit in device status
> >   virtio: introduce vq state as basic facility
> >   virtio: The actions by the device upon SUSPEND
> >   virtqueue: constraints for virtqueue state
> >   virtio-pci: implement VIRTIO_F_QUEUE_STATE
> >
> >  content.tex       | 120 ++++++++++++++++++++++++++++++++++++++++++++++
> >  transport-pci.tex |  15 ++++++
> >  2 files changed, 135 insertions(+)
> >
> > --
> > 2.35.3
> >
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
> > Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.p=
df
> > List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing=
-lists
> > Committee: https://www.oasis-open.org/committees/virtio/
> > Join OASIS: https://www.oasis-open.org/join/
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

