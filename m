Return-Path: <virtio-dev-return-12710-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C14EC77B75
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:08:37 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 745F4C5AEB
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:08:36 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 5AAE8986512
	for <virtio-dev@archiver.kernel.org>; Tue, 16 May 2023 04:08:36 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 426E2983DA0; Tue, 16 May 2023 04:08:36 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2D41C986510
	for <virtio-dev@lists.oasis-open.org>; Tue, 16 May 2023 04:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: RlPEKaPQNciC9LQjrZ-elg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684210111; x=1686802111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ag89AuXqMjwpLJLTrL8gdRIhMQBKN9pOLBbVMIrKkNE=;
        b=LkwpIsoyE87RXa1S8aB+NTFyfGnW3N8ubuOQ4yo/oWv5IQWle7Sre9W/wJQA3J4g86
         w7hTv7OwdiXjEe9YBa9jRYSQuzAhVrfbG99uUZcMtigdd8HnQRlX0kHCFkYiFfsGj7qE
         3cDLg56OVk169749zSW9nq/mPO3AI+9eyN37Tm7Xx9RSJGr5DJKn4DrQxEGdZwZkXd3n
         sYTdNPJDG3Lmm9iUokKY/qOfsmjBhBRhfcoSQF3MJOcNjz6+1FYEDiJfJKDZQ3hIdyTA
         y+lEEnav9QYQxdBOoWQev7flxvnqAKl3KIW/byJfSsz8l001ChgRjE0BqoG7XT/jj62G
         HWzA==
X-Gm-Message-State: AC+VfDylk4shE9Hm9oPjIzpAZOfWXWNTFk/gm+qv/G4Fvr10AfoWMVjt
	ldlgK78j7Kf+GWTH5xHCW4lj088YrGMCX6VbGpVl0k332Ng8N2W6+BF2fdlOMjLfDwf3WR/0fLP
	pUYY6P/Ib9Jly5NXpxUlEzWSPPdKXtrqaJZgqRX+lkxyV
X-Received: by 2002:ac2:5d6b:0:b0:4ee:fdd8:a536 with SMTP id h11-20020ac25d6b000000b004eefdd8a536mr7413088lft.8.1684210111499;
        Mon, 15 May 2023 21:08:31 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6KFXqCm318+YOW8yarDGgeGZ8CfPEZtPpDLSlx5V0rq5PPYGOuz4MLLRK2wXTuub2lExJ1QAoji1R2QfB4PPY=
X-Received: by 2002:ac2:5d6b:0:b0:4ee:fdd8:a536 with SMTP id
 h11-20020ac25d6b000000b004eefdd8a536mr7413075lft.8.1684210111127; Mon, 15 May
 2023 21:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230506000135.628899-1-parav@nvidia.com> <CACGkMEt_2B68a+BZ4-vfeDf_eYj5ZhxrDNd6dxuiF85qr0yN2g@mail.gmail.com>
 <20230507093959-mutt-send-email-mst@kernel.org> <CACGkMEtfMbcu2OPsH6P2tA1aHh2FKygv=xkJ-e1XQzb62nE1vQ@mail.gmail.com>
 <20230510014534-mutt-send-email-mst@kernel.org> <43ec1c8d-7d11-2400-3649-1fe366b1e21b@nvidia.com>
 <20230510121417-mutt-send-email-mst@kernel.org> <PH0PR12MB5481F030A76141320F03956EDC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <PH0PR12MB5481CEB307F413E53B03D502DC779@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEtm5AS50YmPi6A5=gzZZ9Jm55NEJ3GKOTzv-Z0m5E5J_w@mail.gmail.com>
 <PH0PR12MB5481DE0569EC53A862A4D2E9DC749@PH0PR12MB5481.namprd12.prod.outlook.com>
 <893b6ec0-a74f-69b7-95a3-988f0f9382a8@redhat.com> <PH0PR12MB5481CF52380D414AFFBA6A9FDC789@PH0PR12MB5481.namprd12.prod.outlook.com>
 <078af8e2-fb10-b33a-6751-374c4fbd09a9@redhat.com> <PH0PR12MB5481F2BE9C7CB89282E4053DDC799@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481F2BE9C7CB89282E4053DDC799@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 16 May 2023 12:08:20 +0800
Message-ID: <CACGkMEsHqD4UUB8PSpSmwYRhvthGzPJ7Up-9xQ+RO8a1N01-rw@mail.gmail.com>
To: Parav Pandit <parav@nvidia.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "cohuck@redhat.com" <cohuck@redhat.com>, 
	"david.edmondson@oracle.com" <david.edmondson@oracle.com>, "sburla@marvell.com" <sburla@marvell.com>, 
	Yishai Hadas <yishaih@nvidia.com>, Maor Gottlieb <maorg@nvidia.com>, 
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>, Shahaf Shuler <shahafs@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v2 0/2] transport-pci: Introduce legacy registers access
 using AQ

On Tue, May 16, 2023 at 11:45=E2=80=AFAM Parav Pandit <parav@nvidia.com> wr=
ote:
>
>
> > From: Jason Wang <jasowang@redhat.com>
> > Sent: Monday, May 15, 2023 11:28 PM
> >
> > Hi Parav:
> >
> > =E5=9C=A8 2023/5/15 23:49, Parav Pandit =E5=86=99=E9=81=93:
> > >> From: Jason Wang <jasowang@redhat.com>
> > >> Sent: Monday, May 15, 2023 3:11 AM
> > >>> It is just bunch of admin commands in the new SIOV or virtual virti=
o
> > >>> device
> > >> chapter.
> > >>> It is not a transport chapter.
> > >>
> > >> Provisioning could be a part of the transport. For example SR-IOV
> > >> allows static and dynamic provisioning. If a virtio device needs to
> > >> be implemented in VF, it needs to be provisioned first.
> > >>
> > > Provisioning a device by admin !=3D transport guest driver <-> device
> > communication.
> > >
> > > Two very different things.
> >
> >
> > When developing a new transport, we need to consider at least how to pr=
obe
> > the device. Before probe the device, it needs to be provisioned.
> Yes, and yes to both. I agree.
>
> > If we want a new transport, it could implement the provisioning especia=
lly if it
> > want the design to be bus independent. For the proposal like transport
> > virtqueue, it's also fine to use bus specific facility to provision and=
 probe the
> > device.
> >
> Provisioning is for defining the transport specific attributes.
> Each transport has few command things and few unique things.
> So provisioning commands can define transport specific attributes and few=
 generic things.
> This is fine.
>
> >
> > That is what I want to say.
> >
> >
> > >
> > >>>>> And the motivation is also clear is to provide composing a virtio
> > >>>>> device for the
> > >>>> guest VM for the backward compatibility for 1.x part of the specif=
ication.
> > >>>>> It seems fine and indeed orthogonal to me that: it is for backwar=
d
> > >>>> compatibility for already defined config fields for existing guest=
 VM driver.
> > >>>>> It does not conflict with the cfgq/cmdq idea whose main purpose i=
s
> > >>>>> for the
> > >>>> new config fields, new use cases that doesn't require any mediatio=
n.
> > >>>>> Such cfgq works across PF, VF, SF/SIOV devices in uniform way
> > >>>>> without
> > >>>> mediation.
> > >>>>
> > >>>> My understanding is that the cfgq/cmdq could be done on top, since
> > >>>> the commands are part of transport unless I miss something.
> > >>>>
> > >>> On top of what?
> > >>> cfgq/cmdq is just another queue like any other VQ.
> > >>> it is orthogonal to accessing 1.x registers using group owner's que=
ue.
> > >>
> > >> I think there hasn't been any proposal that call any virtqueue like
> > >> cfgq/cmdq. So using that may cause a lot of misunderstanding. I thin=
k
> > >> the context here is to provide or extend transport facilities via a
> > >> virtqueue not something like the control virtqueue.
> > > The context is to compose a PCI device for a guest which for the curr=
ently
> > defined features.
> > > Once a new attribute is done using cfgq/cmdq there is no problem of
> > transporting it via its group member.
> > >
> > > And therefore, saying any new attribute also to ride on same tranport=
q/aq via
> > is not appropriate.
> >
> >
> > The point is to try to find if there's a better way, more below.
> >
> >
> > >
> > >> Admin virtqueue doesn't preventing anything from letting IMS go
> > >> directly to the device.
> > > But there is no aq/cfgq/cmdq defined for the guest, so with current p=
roposal it
> > is prevented.
> >
> >
> > It's a choice of the implementation but not spec. Spec doesn't say admi=
nq can't
> > be used for guest.
> >
> For guest and by guest are two different things.
> I am proposing that a cfgq/cmdq should be used directly by the guest driv=
er as base line like any other VQ.

I'm fine with this, but if I understand correctly, but I don't see any
proposal like this that is posted to the list?

> And if there is a need for mediation, it should be possible.
>
> > I think we've discussed many times that legacy is tricky for hardware.
> And we want to proceed for the described use case and requirements.
>
> > And your proposal proves this further by introducing modern alike
> > notification areas.
> Not really. A modern device is offering the notification area like legacy=
 to the legacy interface.
> So this is just fine.

I don't say it's not fine, it's pretty fine and transport virtqueue
have similar commands. And this also answer the question that you
think tunnel PCI over adminq is not scalable. We can keep this command
in that case as well, or invent new capabilities.

>
> > We probably need to deal with others like endianess.
> >
> No point in discussing this again. One size does not fit all.
> It solves large part of the use cases so it is valuable and will be suppo=
rted.

This is doable, we need to leave some space for future development. Or
is it just complicated to have an endian command?

>
> > For any case, having a simple and deterministic device design is always
> > better assuming we've agreed that mediation is a must for legacy
> > drivers. Using dedicated commands can make sure the implementation won'=
t
> > need to go with corner cases of legacy.
> >
> Corner case handling just moved from the device to hypervisor.

That's not safe, the device should be ready for malicious inputs.

>
> >
> > >
> > >>> Its same thing using more opcodes.
> > >>
> > >> Do we really care about the number of opcodes? I think we've reserve=
d
> > >> sufficient spaces.
> > >>
> > > I don=E2=80=99t see opcode as problem, we have plenty.
> > > And hence, when there is a device that _does not implement config spa=
ce for
> > SIOV/SF, it should be introduced.
> > > It is the introduction and bisection at the hypervisor level unnecess=
ary.
> > >
> > > And I don=E2=80=99t have object to it either, the main reason is: I d=
on=E2=80=99t see it being
> > useful for 1.x access going forward.
> >
> >
> > As you said for future SIOV/SF? For example, it can have better
> > scalability in IMS since it doesn't require any real capabilities or
> > registers.
> >
> For SIOV there is no backward compatibility requirement.

It has several ways to support current virtio-pci drivers in the
guest, and such compatibility is almost a must for the public cloud.
We can't enforce the user to reinstall/recompile their
kernels/application in order to work for SIOV.

> Hence, it can start with fresh infra for real capabilities, registers and=
 IMS.
>
> >
> > >
> > >>>> 1) Modern transport, admin virtqueue with well defined transport
> > >> commands
> > >>>> 2) Legacy transport, works moe like a PCI transport on top of the =
admin
> > >>>> virtqueue
> > >>>>
> > >>>> Transport virtqueue tend to be transport independent, but 2) tie i=
t
> > somehow
> > >> to
> > >>>> the PCI. That's why I suggest to
> > >>>>
> > >>> The 4 patches are not transporting all the PCI things over transpor=
t VQ. it is
> > >> not a transport.
> > >>
> > >>
> > >> It really depends on the different viewpoint.
> > > You wrote/asked for "PCI transport over admin q".
> > > That means PCI capabilities, PCI config registers and all things defi=
ned in the
> > PCI transport section to go over the AQ.
> > > This is clearly not the objective of these 2 patches.
> >
> >
> > It's not but it can achieve the same function as this series with much
> > broader use cases.
> >
> >
> > > Nor it is your proposal of transport VQ.
> >
> >
> > Same as the above.
> >
> > I think we know your proposal might but it's worthwhile to figure out
> > whether or not there could be other better ways to achieve the same
> > thing. That's why the discussion happens on the cover letter.
> >
>
> > Both transport virtqueue and "PCI over adminq" can support legacy guest
> > with a lot of other use cases.
> >
> PCI over admin queue just doesn=E2=80=99t work at performance scale to tr=
ansport doorbells over a queue interface.
> So, things just stop there.

I think we are discussing what it can be, so see the above reply for
the notification areas, we can stick
virtio_admin_cmd_lq_notify_query_result command for PCI over adminq,
or invent new capabilities to make it fully self contained.

>
> >
> > >
> > > You only want to exchange currently defined config registers, interru=
pts and
> > notification configuration using AQ.
> > >
> > > Transport VQ is NOT transporting actual data, it is not transporting
> > notifications etc.
> > > It is just a config channel.
> > > Hence, they are just commands not a "full transport".
> >
> >
> > For any case, a virtqueue could not be a full transport. It needs bus
> > facilities to do bootstrap/DMA/notifications at least. The idea is to
> > save for transport specific resources and use a more scalable way to
> > config devices.
> >
> Hence it needs only needs a cfgq, not the full transport. :)
>

Well, not a native speaker but I'm fine if you want to call it configq.

> >
> > >
> > >> To me, adminq is not
> > >> specific to PCI, so this proposal looks more like a partial transpor=
t
> > >> for legacy.
> > > It is not a partial transport for legacy.
> > > A future transport may be able to do for SIOV/MMIO by adding those gr=
oup
> > member identifier.
> > >
> > > Hence, I agreed that commands in the tranportvq proposal is fine, as
> > commands, not as new transport.
> > >
> > >> So we have
> > >>
> > >> 1) all commands via PCI
> > >> 2) all commands via adminq
> > >> 3) part of the commands via PCI and the rest via adminq
> > >>
> > >> This proposal goes to for 3 with transport specific commands while I
> > >> think we need to try 1 and 2 then it is more general and it helps to
> > >> avoid duplication with future features.
> > >>
> > > All legacy interface via AQ.
> >
> >
> > That's pretty fine. So we have already had modern transport via a
> > virtqueue, why not unify the design to avoid duplication? Otherwise we
> > may end up with
> >
> > 1) legacy PCI alike commands via admin virtqueue with modern alike
> > notification areas
> Modern commands on SIOV device for some backward compat is needed.
> A brand new SIOV device doesn=E2=80=99t need it.

So I meant, if we invent legacy commands for transport/admin/config
virtqueue, we don't need those PCI alike commands.

Thanks

>
> > 2) modern device commands via admin virtqueue


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

