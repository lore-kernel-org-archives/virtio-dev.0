Return-Path: <virtio-dev-return-13530-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247A2C04A6A
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:37:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 68B84F3F73
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:37:52 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 317179863C9
	for <virtio-dev@archiver.kernel.org>; Tue, 15 Aug 2023 00:37:52 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 16752983C28; Tue, 15 Aug 2023 00:37:52 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 00A6398633F
	for <virtio-dev@lists.oasis-open.org>; Tue, 15 Aug 2023 00:37:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: rJeYcgEOOT2mY6gR5EE3yQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692059863; x=1692664663;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNao85iwWgssK0PU/PX8UpEZQIsDcReB8bmELkRCepc=;
        b=HSl+HI/rkU4JMGG/uoYvEtUjJr0fM3+2ClaIfrpO0naHrymM0QU34x2ECafaucfZtx
         1aqSlXA1TWu//IqC3GGKDTLOeJpOcDfu3POTxGNjIjNdji1oLa9sqYvyAww6uxqZbVtE
         gIacvVhfIMBAoysrmGkYk6q5kyntRYSakFnkOcIwWCfMGPe/Om1PutXED2Q7Yk/BmPgn
         Xezkpb9MDeSAU2XqwZy038fsTgg8YviKPgPZPdwCwgmP2HMpOBASa89GpeRrfhQZL21g
         wKKFVsoh5Vq/dtINlUpA11GmhCNywH7mpFSm5jDDYKiAnnhjR6cpi8JCW120zTDf9qU/
         nETA==
X-Gm-Message-State: AOJu0Yy/UuhIF05PEUp+MqTX64A9+TaImCeuIsc7NuekLZAtuwy6THfb
	PkSDvxa7mwyMJKX3mz0uEOhyvRcBR1dI+Gcdb2IdK5c1fRqXa2EdSt0MZ6oQYCOlkSPk/lLyQqV
	c/VO/QEwSNX8dO5jvoIuQXqGIg1KctMpED4K4RbiHp1I/fQwJQFJPPaM=
X-Received: by 2002:a2e:8612:0:b0:2b9:dd5d:5d0a with SMTP id a18-20020a2e8612000000b002b9dd5d5d0amr7377901lji.40.1692059863047;
        Mon, 14 Aug 2023 17:37:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx+n4bVESwlv6nYRNacI/g0e6cH7bse5ofDPcmtKqwi8YTTpCXPWtAfqA+uthiWEfmHOB45DZfkFQSMJPqz6Q=
X-Received: by 2002:a2e:8612:0:b0:2b9:dd5d:5d0a with SMTP id
 a18-20020a2e8612000000b002b9dd5d5d0amr7377897lji.40.1692059862759; Mon, 14
 Aug 2023 17:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230814192904.30062-1-lingshan.zhu@intel.com>
 <20230814192904.30062-2-lingshan.zhu@intel.com> <CACGkMEvmYqKTk1Hveo96oKYw4hbEDJD2x5Ye3_nkeBTH0rcMMw@mail.gmail.com>
In-Reply-To: <CACGkMEvmYqKTk1Hveo96oKYw4hbEDJD2x5Ye3_nkeBTH0rcMMw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 15 Aug 2023 08:37:31 +0800
Message-ID: <CACGkMEt4mYmf+6+WC=WEZqiJgO2tNo96Ekr5bbyN6akxpjwFqw@mail.gmail.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: mst@redhat.com, eperezma@redhat.com, cohuck@redhat.com, 
	virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC PATCH 1/5] virtio: introduce SUSPEND bit in device status

On Tue, Aug 15, 2023 at 8:26=E2=80=AFAM Jason Wang <jasowang@redhat.com> wr=
ote:
>
> On Mon, Aug 14, 2023 at 7:29=E2=80=AFPM Zhu Lingshan <lingshan.zhu@intel.=
com> wrote:
> >
> > This patch introudces a new status bit in the device status: SUSPEND.
> >
> > This SUSPEND bit can be used by the driver to suspend a device,
> > in order to stablize the device states and virtqueue states.
> >
> > Its main use case is live migration.
>
> I think patch 3 needs to be squashed into this one.
>
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > Signed-off-by: Eugenio P=C3=83rez <eperezma@redhat.com>
> > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > ---
> >  content.tex | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/content.tex b/content.tex
> > index 0a62dce..1bb4401 100644
> > --- a/content.tex
> > +++ b/content.tex
> > @@ -47,6 +47,9 @@ \section{\field{Device Status} Field}\label{sec:Basic=
 Facilities of a Virtio Dev
> >  \item[DRIVER_OK (4)] Indicates that the driver is set up and ready to
> >    drive the device.
> >
> > +\item[SUSPEND (16)] When VIRTIO_F_SUSPEND is negotiated, indicates tha=
t the
> > +  device has been suspended by the driver.
> > +
> >  \item[DEVICE_NEEDS_RESET (64)] Indicates that the device has experienc=
ed
> >    an error from which it can't recover.
> >  \end{description}
> > @@ -73,6 +76,10 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >  recover by issuing a reset.
> >  \end{note}
> >
> > +The driver MUST NOT set SUSPEND if FEATURES_OK is not set.
> > +
> > +When set SUSPEND, the driver MUST re-read \field{device status} to ens=
ure the SUSPEND bit is set.
> > +
> >  \devicenormative{\subsection}{Device Status Field}{Basic Facilities of=
 a Virtio Device / Device Status Field}
> >
> >  The device MUST NOT consume buffers or send any used buffer
> > @@ -82,6 +89,13 @@ \section{\field{Device Status} Field}\label{sec:Basi=
c Facilities of a Virtio Dev
> >  that a reset is needed.  If DRIVER_OK is set, after it sets DEVICE_NEE=
DS_RESET, the device
> >  MUST send a device configuration change notification to the driver.
> >
> > +The device MUST ignore SUSPEND if FEATURES_OK is not set.
>
> Is there any value to allow SUSPEND to be set without DRIVER_OK?
>
> > +
> > +The deivce MUST ignore SUSPEND if VIRTIO_F_SUSPEND is not negotiated.
>
> typo.
>
> Thanks

Btw, it's not clear to me if driver is allowed to clear this bit.

Thanks

>
> > +
> > +If VIRTIO_F_SUSPEND is negotiated and SUSPEND is set, the device MUST =
clear SUSPEND
> > +and resumes operation upon DRIVER_OK.
> > +
> >  \section{Feature Bits}\label{sec:Basic Facilities of a Virtio Device /=
 Feature Bits}
> >
> >  Each virtio device offers all the features it understands.  During
> > @@ -872,6 +886,10 @@ \chapter{Reserved Feature Bits}\label{sec:Reserved=
 Feature Bits}
> >         \ref{devicenormative:Basic Facilities of a Virtio Device / Feat=
ure Bits} for
> >         handling features reserved for future use.
> >
> > +  \item[VIRTIO_F_SUSPEND(41)] This feature indicates that the driver c=
an
> > +   SUSPEND the device.
> > +   See \ref{sec:Basic Facilities of a Virtio Device / Device Status Fi=
eld}.
> > +
> >  \end{description}
> >
> >  \drivernormative{\section}{Reserved Feature Bits}{Reserved Feature Bit=
s}
> > --
> > 2.35.3
> >


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

