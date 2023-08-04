Return-Path: <virtio-dev-return-13460-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D871C001DB
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 03:31:51 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A7267120D49
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 03:31:50 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 8DE54986724
	for <virtio-dev@archiver.kernel.org>; Fri,  4 Aug 2023 03:31:50 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7A5B69866DD; Fri,  4 Aug 2023 03:31:50 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6615D9866DF
	for <virtio-dev@lists.oasis-open.org>; Fri,  4 Aug 2023 03:31:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: OpW1OnAkN2W8Q8XDArOnZw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691119906; x=1691724706;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bawPXVVJteBCfNWcZ9WiYh7HuizC5oHnc+/Kw69upLU=;
        b=Er4KYv7yfGJAnTYIa+ZkxuL1e0TwMiQW3hmlL9KCUd3uKHjVVqPGsJ8TQPU4LEL3rp
         F9212gkC9xr+fiTnIMsYL5FfWBfkt9zZQ9mpn40MzLn1heH3Z/s2dNsc41+KfMfKZJk6
         CfhJSIKlmWX23kyPjw0n0pmPWLETVGWlGF1bXKaIqEtrHqzRSOpz/b+ywpxl4gRWYhgW
         pLSvJ4Efzpry2Co7pvPTXWWDwQmTMYC/paVA5jEiaokENyfh2GUKbztAoLexoIhYYzm9
         BEskJrbUK/Ef4lwBMdNjN6UAZIJs4VS9zb8t1erqMJHzjPfN426FhFs+yLjV2giGQQNa
         kWGw==
X-Gm-Message-State: AOJu0YwziHY5bda68NC+jpm/8nzRr5/iXgGSb9UfNsUl0ty79Nk5ivpG
	8dj2FNk6PgqTP9QWkJ/PhPJkDpDjoRqLFSuReb8KDza9m6lYrPwwCbHUJqfmbJcLbRJUUTb9prw
	o3OFYrTGyNVe5nCMclubZYjgkwjVLwESpW19tL2C1U6/b
X-Received: by 2002:a2e:9196:0:b0:2b6:e958:5700 with SMTP id f22-20020a2e9196000000b002b6e9585700mr547505ljg.4.1691119906334;
        Thu, 03 Aug 2023 20:31:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0dShLPRqMVh6kspW57FXMCWWcx0boozjtjHIewIZv/YANPn/CXFMyBppAkuCjdQYi12T+Fz9RKPQsbedhv40=
X-Received: by 2002:a2e:9196:0:b0:2b6:e958:5700 with SMTP id
 f22-20020a2e9196000000b002b6e9585700mr547494ljg.4.1691119905885; Thu, 03 Aug
 2023 20:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com> <20230803054333-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230803054333-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 4 Aug 2023 11:31:34 +0800
Message-ID: <CACGkMEsdM+bi_scj6kgo7FrRDNGwF-=37bT8tOC6DXg9fTuNRw@mail.gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, virtio-dev@lists.oasis-open.org, 
	Parav Pandit <parav@nvidia.com>, virtio-comment@lists.oasis-open.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [RFC] virtio-net: support access and control the member devices

On Thu, Aug 3, 2023 at 5:44=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Thu, Aug 03, 2023 at 04:31:50PM +0800, Xuan Zhuo wrote:
> > Now we have the concept of the device group. This allows us to
> > support sr-iov and siov more conveniently.
> >
> > The following description uses pf, vf as an example. The scene with sf
> > should be similar.
> >
> > According to my understanding, the management at the level of virtqueue
> > should be handled by admin queue. And the net related management is
> > still managed by cvq of pf. So this patch works with the cvq of the pf.
> >
> > The problem I am trying to solve is when there are multiple vf
> > virtio-net devices under one pf.
> > It is necessary for administrators to query the status and information
> > of each vf and configure mac.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
>
> I think we should use admin queue for this, and not cvq.

I think we probably need some split here.

E.g the fields belonging to configuration space might go with a more
general interface like admin command/queue.

The net specific ones need to go through a net specific interface.
(cvq of PF or reps)

Thanks


>
> > ---
> >  device-types/net/description.tex        | 72 +++++++++++++++++++++++--
> >  device-types/net/device-conformance.tex |  1 +
> >  2 files changed, 70 insertions(+), 3 deletions(-)
> >
> > diff --git a/device-types/net/description.tex b/device-types/net/descri=
ption.tex
> > index 76585b0..1494a18 100644
> > --- a/device-types/net/description.tex
> > +++ b/device-types/net/description.tex
> > @@ -88,6 +88,9 @@ \subsection{Feature bits}\label{sec:Device Types / Ne=
twork Device / Feature bits
> >  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
> >      channel.
> >
> > +\item[VIRTIO_NET_F_ACCESS_MEMBER_DEVICE(51)] Device can access and con=
trol the
> > +    member devices.
> > +
> >  \item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash =
for encapsulated packets.
> >
> >  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notific=
ation coalescing.
> > @@ -1156,6 +1159,7 @@ \subsubsection{Control Virtqueue}\label{sec:Devic=
e Types / Network Device / Devi
> >          u8 command;
> >          u8 command-specific-data[];
> >          u8 ack;
> > +        u8 command-specific-data-reply[];
> >  };
> >
> >  /* ack values */
> > @@ -1164,9 +1168,11 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
> >  \end{lstlisting}
> >
> >  The \field{class}, \field{command} and command-specific-data are set b=
y the
> > -driver, and the device sets the \field{ack} byte. There is little it c=
an
> > -do except issue a diagnostic if \field{ack} is not
> > -VIRTIO_NET_OK.
> > +driver, and the device sets the \field{ack} byte and optionally
> > +\field{command-specific-data-reply}. There is little the driver can
> > +do except issue a diagnostic if \field{ack} is not VIRTIO_NET_OK.
> > +
> > +The command VIRTIO_NET_CTRL_MEMBER_GET_INFO contains \field{command-sp=
ecific-data-reply}.
> >
> >  \paragraph{Packet Receive Filtering}\label{sec:Device Types / Network =
Device / Device Operation / Control Virtqueue / Packet Receive Filtering}
> >  \label{sec:Device Types / Network Device / Device Operation / Control =
Virtqueue / Setting Promiscuous Mode}%old label for latexdiff
> > @@ -1805,6 +1811,66 @@ \subsubsection{Control Virtqueue}\label{sec:Devi=
ce Types / Network Device / Devi
> >
> >  Upon reset, a device MUST initialize all coalescing parameters to 0.
> >
> > +\paragraph{Member Device}\label{sec:Device Types / Network Device / De=
vice Operation / Control Virtqueue / Member Info}
> > +
> > +If a deivce is the own deivce inside one device group and the feature
> > +VIRTIO_NET_F_ACCESS_MEMBER_DEVICE is negotiated, the own driver can ob=
tain
> > +the info and change the configuration of the member devices of this de=
vice
> > +group.
> > +
> > +\begin{lstlisting}
> > +struct virtio_net_ctrl_member {
> > +        le64 group_member_id;
> > +};
> > +
> > +struct virtio_net_ctrl_member_info_reply {
> > +        u8 mac[6];
> > +        le16 status;
> > +        le16 max_virtqueue_pairs;
> > +        le16 mtu;
> > +        le32 speed;
> > +        u8 duplex;
> > +        u8 driver_ok;
> > +        le16 current_virtqueue_pairs;
> > +};
> > +
> > +struct virtio_net_ctrl_member_set_mac {
> > +        le64 group_member_id;
> > +        u8 mac[6];
> > +};
> > +
> > +#define VIRTIO_NET_CTRL_MEMBER 7
> > + #define VIRTIO_NET_CTRL_MEMBER_GET_INFO  0
> > + #define VIRTIO_NET_CTRL_MEMBER_SET_MAC   1
> > +\end{lstlisting}
> > +
> > +\devicenormative{\subparagraph}{Member Device}{Device Types / Network =
Device / Device Operation / Control Virtqueue / Member Device}
> > +
> > +The device only offers the feature VIRTIO_NET_F_ACCESS_MEMBER_DEVICE w=
hen it is
> > +the own device.
> > +
> > +If the \field{group_member_id} is not within the range of the member d=
evice id,
> > +the own device MUST respond with VIRTIO_NET_ERR.
> > +
> > +struct virtio_net_ctrl_member_info_reply is used to reply the command
> > +VIRTIO_NET_CTRL_MEMBER_GET_INFO via \field{command-specific-data-reply=
}.
> > +
> > +If the member device specified by the \field{group_member_id} is in th=
e
> > +DRIVER_OK status, the own device MUST set the \field{driver_ok} to 1 a=
nd set the
> > +\field{current_virtqueue_pairs} to the number of virtqueue pairs that =
are being
> > +used by the member device. Otherwise, both \field{driver_ok} and
> > +\field{current_virtqueue_pairs} MUST be set to zero.
> > +
> > +All other fields of the struct virtio_net_ctrl_member_info_reply MUST =
be equal
> > +to the values in the struct virtio_net_config of the member device.
> > +
> > +If the member device specified by the \field{group_member_id} supports
> > +VIRTIO_NET_F_MAC and its status is not DRIVER_OK, the own device MUST =
reply to
> > +VIRTIO_NET_CTRL_MEMBER_SET_MAC with VIRTIO_NET_OK, and the member devi=
ce MUST
> > +offer the \field{mac} to the member driver via the struct virtio_net_c=
onfig.
> > +Otherwise, the own device MUST reply to the command
> > +VIRTIO_NET_CTRL_MEMBER_SET_MAC with VIRTIO_NET_ERR.
> > +
> >  \subsubsection{Legacy Interface: Framing Requirements}\label{sec:Devic=
e
> >  Types / Network Device / Legacy Interface: Framing Requirements}
> >
> > diff --git a/device-types/net/device-conformance.tex b/device-types/net=
/device-conformance.tex
> > index f88f48b..9af3293 100644
> > --- a/device-types/net/device-conformance.tex
> > +++ b/device-types/net/device-conformance.tex
> > @@ -15,4 +15,5 @@
> >  \item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Notifications Coalescing}
> >  \item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Inner Header Hash}
> > +\item \ref{devicenormative:Device Types / Network Device / Device Oper=
ation / Control Virtqueue / Member Device}
> >  \end{itemize}
> > --
> > 2.32.0.3.g01195cf9f
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

