Return-Path: <virtio-dev-return-14353-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5C9C48BF6
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 08:47:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 7A0312AF9D
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 08:47:12 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 68357986484
	for <virtio-dev@archiver.kernel.org>; Mon, 26 Feb 2024 08:47:12 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5B3DC98632B; Mon, 26 Feb 2024 08:47:12 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49FC7986339
	for <virtio-dev@lists.oasis-open.org>; Mon, 26 Feb 2024 08:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708937222; x=1709542022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q6tdK7nnVUxCrfYqbBDrt7NYElZWyRxKChFW3ruP1KA=;
        b=WTtP4+N6Dq2OBar/5xUKZD/2pAovAa/VO+zc73tMm/uyd9FVIJVxVQNyOK8kuqL3EN
         JrtbBvZWmfn8zaQa2O2PrCgLAe+mzKrmMQJxhS5q31uQ/gjvw66z5n/6UuYwAeHrTdEO
         mAtlbVqcwOLq5YhhtESVZDm6XRNPw5DLwE74LwN9fLoTwFrNUKkB/RJg8D4XhgapJzJE
         NRtt4tvi/AnbO2oUKZCfgVWf971xvUezlfrCSOPeCPTDLRmgB3VDAJLP5+4DdjyvtvrL
         hCX27H+yOXVNxQUVVagYJKd3Ng8FR+8zlLGfde6OGbljcIlUBVoU0hJh3F2pSfe5S9Qq
         c/wA==
X-Forwarded-Encrypted: i=1; AJvYcCVVbP6k3xS52Df43nSqof4PlRAJg41cQ3Pm0/JVVfBwYaytbHizKok80LHLKYqESkWIIbHzIMRaWnsIiKFalEH/amVRnEjGcVt+vQ83Ggsb
X-Gm-Message-State: AOJu0YxTg9WgM4DBzSUTSPGVAXlVqvM8u1iEW/8yr1b96bmy5kxtBctt
	/agmmTbTlrRuOmh6i6hy77bvKq9z8mokt4OsCVK85AbZvTHSpN9aq863prYhBPsb43n6Hqjuixs
	9iysXPyHwV+72++U6dvkKM5SNyKYkXQbo29be
X-Google-Smtp-Source: AGHT+IEdwgUafGElOd5bGm3XjeiFTkHH05SY+4n9C2OqlSfA3ATU773l/6c1GpLgCALiXE4Jn3pbrbdnh7Z/3P0xOiA=
X-Received: by 2002:a05:6512:715:b0:512:ed25:a464 with SMTP id
 b21-20020a056512071500b00512ed25a464mr3208831lfs.5.1708937222295; Mon, 26 Feb
 2024 00:47:02 -0800 (PST)
MIME-Version: 1.0
References: <20240216082432.709956-1-stevensd@chromium.org>
 <20240216082432.709956-2-stevensd@chromium.org> <CACGkMEuP=ZcbRf4G8O1hBjg0s5uNbrRMO=ESnU0AKWSHmF_fMQ@mail.gmail.com>
In-Reply-To: <CACGkMEuP=ZcbRf4G8O1hBjg0s5uNbrRMO=ESnU0AKWSHmF_fMQ@mail.gmail.com>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 26 Feb 2024 17:46:50 +0900
Message-ID: <CAD=HUj5-N=rra9BBbNgV3uAtGGwAmK6sRhA6eNaG5O5L95KPag@mail.gmail.com>
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, virtio-comment@lists.oasis-open.org, 
	virtio-dev@lists.oasis-open.org, parav@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v4 1/1] Add suspend support for virtio PCI devices

On Mon, Feb 26, 2024 at 3:42=E2=80=AFPM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Fri, Feb 16, 2024 at 4:25=E2=80=AFPM David Stevens <stevensd@chromium.=
org> wrote:
> >
> > Add a virtio power management PCI capability to allow drivers to suspen=
d
> > virtio PCI devices. This allows drivers to suspend devices at the virti=
o
> > level before suspending them at the PCI transport layer. This allows
> > drivers to do a two phase suspend, which prevents notifications from
> > being ignored or lost if interrupts are reconfigured at the PCI
> > transport layer immediately before or after the device is put into the
> > PCI PM D3 low power state.
> > ---
> >  transport-pci.tex | 51 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
>
> I would like to know how the two phase suspend can prevent the loss of
> notification or interrupt. Or for example, if it can be workaround at
> the driver level.

I'll preface this by saying I am not an expert in how Linux handles
interrupts or in PCI, so I might be missing some important
information.

Actually, after thinking about this some more, I'm not sure that the
two phase suspend is necessary per-se. Rather, I think relying only on
PCI power management is simply insufficient.

According to the kernel's system suspend and device interrupts
documentation [1], "... after the 'late' phase of device suspend there
is no legitimate reason why any interrupts from suspended devices
should trigger and if any devices have not been suspended properly
yet, it is better to block interrupts from them anyway." PCI power
management doesn't occur until the noirq phase of suspend, so that's
too late to be useful here. Other than that, as of right now, there's
nothing the driver can do to tell devices they need to stop sending
interrupts. Adding suspend support to the virtio spec would address
this deficiency.

More concretely, I ran into two problems when trying to get shallow
suspend working with only PCI power management. If there are
workarounds for this at the driver level, then that would be great.
But I can't think of any, at least.

First, there is a window between when Linux suspends interrupts with
suspend_device_irqs and when PCI power management occurs. If the
device triggers an interrupt in that window, then it won't be lost
since IRQS_PENDING gets added to the descriptor state. However, if the
originating event should have woken the guest up from sleep, then that
doesn't happen, since there is no way for the device to know it
actually needed to generate a PCI PME. I might be missing something,
but this seems like something that can't be worked around at the
driver level.

Second, the core interrupt code can migrate interrupts when CPUs are
offline'ed entering shallow suspend. Since PCI devices are already in
D3 at this point, __pci_write_msi_msg does not update the MSI routing.
When bringing the device back up, there is a window between when the
device is put into D0 and when the updated routing tables are written
by __pci_restore_msix_state. If the device sends an interrupt in this
window, then it will be sent to the completely wrong handler in the
guest (or dropped if there is no handler installed). I guess this
could be worked around in the core PCI code by masking MSIX interrupts
before suspending the device. However, the fact that Linux doesn't
already do that today suggests that we're wrong, rather than everybody
else happens to be wrong in just the right way.

[1] https://www.kernel.org/doc/Documentation/power/suspend-and-interrupts.r=
st

-David

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

