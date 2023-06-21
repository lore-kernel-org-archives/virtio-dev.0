Return-Path: <virtio-dev-return-13012-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E46FEB64D7
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:25:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 458817C6A4
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:25:44 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 23E599865C9
	for <virtio-dev@archiver.kernel.org>; Wed, 21 Jun 2023 19:25:44 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 0BF5F9865BA; Wed, 21 Jun 2023 19:25:44 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id EC80C9865C1
	for <virtio-dev@lists.oasis-open.org>; Wed, 21 Jun 2023 19:25:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: NQUS6TbKNriLtgr3pHb_lg-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687375539; x=1689967539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r85hV/tBJ1qFK5aqJB2tQVuvj06bd6r1QaBXyvefOnc=;
        b=iN+rbuTpcSKXvWIbey7oxsR1EuzyKsHRZgrrGCps6LUA2j5c4d8Bv/9C+kB4nfOR76
         Waj1olcqMBwuyGvW77JsptZKvcDQLrM64wFC2ZPFSiOEBcJPvQfg9dH8RBn+rOl9TvFU
         zusuze/0kTTiC+lJJi322vhtkpbz/0OnlxnQDokEq4ajgHAgVeRUngbNrnCXmjglVYL3
         DUkNROlKlINU1MbjJDHMHexkMOcloAnBD4b9dGTpAtjRJpRR7MxNgzrwRwAFPcFyIIh3
         GMyj+caB5tnk2HhWeCGc6K5vbBbZu6bwb8BcINzbKL+Kd5soAKKFYAxZPLeNm6VsLNOV
         J7lA==
X-Gm-Message-State: AC+VfDwLI7Mlnu8+NbvFxR/s3pTGP9UHmGgveLDO3i5s6Qw6y9giwBLd
	OcXrZbWSzMkUhi7aTg6+zRfIgLmtSoJWhz2NMD4ILr32m8X48WTk+cYIjJpHH+30kzs+RGK2OKu
	xn7KMgupxjQuSdseUEakf+L4h1VKi
X-Received: by 2002:a17:907:7290:b0:988:e6dc:bfae with SMTP id dt16-20020a170907729000b00988e6dcbfaemr7008152ejc.24.1687375538902;
        Wed, 21 Jun 2023 12:25:38 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7P/StBNElJyeCn5CMeaIOpL6o5IlWfU09hhzPcLhwadiqNeQh4e8dFud1fVWxoAdIIgUhB+A==
X-Received: by 2002:a17:907:7290:b0:988:e6dc:bfae with SMTP id dt16-20020a170907729000b00988e6dcbfaemr7008126ejc.24.1687375538405;
        Wed, 21 Jun 2023 12:25:38 -0700 (PDT)
Date: Wed, 21 Jun 2023 15:25:34 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Cornelia Huck <cohuck@redhat.com>
Message-ID: <20230621152451-mutt-send-email-mst@kernel.org>
References: <20230621135052.76028-1-hengqi@linux.alibaba.com>
 <20230621104647-mutt-send-email-mst@kernel.org>
 <20230621164606.GI74977@h68b04307.sqa.eu95>
 <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB54819746DF66F968E532195EDC5DA@PH0PR12MB5481.namprd12.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v18] virtio-net: support inner
 header hash

On Wed, Jun 21, 2023 at 05:52:28PM +0000, Parav Pandit wrote:
> 
> > From: Heng Qi <hengqi@linux.alibaba.com>
> > Sent: Wednesday, June 21, 2023 12:46 PM
> 
> 
> > SET carries an additional 32 bits of information. But if you think this will make
> > the overall structure more concise, I'm ok.
> >
> If it is placed in single structure than it needs to be reworded to remove WO or RO notion.

Not really. all of structure is RO and WO.

> This also requires additional sw to indicate dma attributes to be RW when mapping this area.
> And extra text to indicate that supported_hash_tunnel_types to be ignored on set command.
> 
> Two structures are more cleaner serving its purpose.

No because all of structure is RO or WO.

> > > I also think hash_tunnel is unnecessarily verbose, and _config_ is
> > > also pointless.
> > >
> > > Returning supported_hash_tunnel_types back to device can also be
> > > useful for debugging.
> > >
> > > How about:
> > >
> > >
> > > struct virtnet_hash_tunnel {
> > >      le32 supported_tunnel_types;
> > >      le32 enabled_tunnel_types;
> > > };
> > >
> > 
> > It's OK.
> > 
> > And:
> > For the GET command, both fields are WO for the device.
> > For the SET command, \field{supported_tunnel_types} is RO for the device and
> > \field{enabled_tunnel_types} is WO for the device.
> > 
> > >
> > > For VIRTIO_NET_CTRL_HASH_TUNNEL_GET, \field{supported_tunnel_types}
> > > contains the bitmask of encapsulation types supported by the device
> > > for inner header hash; \field{enabled_tunnel_types} contains the value
> > > received in a previous successful call to
> > > VIRTIO_NET_CTRL_HASH_TUNNEL_SET.
> > >
> > > For VIRTIO_NET_CTRL_HASH_TUNNEL_SET, \field{supported_tunnel_types}
> > > contains the value returned by a previous successful call to
> > > VIRTIO_NET_CTRL_HASH_TUNNEL_GET; \field{enabled_tunnel_types}
> > contains
> > > the bitmask of encapsulation types to enable for inner header hash.
> > >
> > > and add normative statements to this end.
> > >
> > >
> > 
> > Ok.
> > 
> > > > +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7  #define
> > > > +VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0  #define
> > > > +VIRTIO_NET_CTRL_HASH_TUNNEL_GET 1
> > > > +
> > > > +
> > > > +Field \field{supported_hash_tunnel_types} provided by the device
> > indicates that the device supports inner header hash for these encapsulation
> > types.
> > > > +Field \field{supported_hash_tunnel_types} contains the bitmask of
> > encapsulation types supported for inner header hash.
> > >
> > > We don't need these two sentences. Just second one will do.
> > >
> > 
> > Ok.
> > 
> > > > +See \ref{sec:Device Types / Network Device / Device Operation /
> > > > +Processing of Incoming Packets / Hash calculation for incoming packets /
> > Encapsulation types supported/enabled for inner header hash}.
> > > > +
> > > > +Field \field{hash_tunnel_types} contains the bitmask of encapsulation
> > types enabled for inner header hash.
> > >
> > > They have different meanings for set and get though.
> > >
> > >
> > > > +See \ref{sec:Device Types / Network Device / Device Operation /
> > > > +Processing of Incoming Packets / Hash calculation for incoming packets /
> > Encapsulation types supported/enabled for inner header hash}.
> > > > +
> > > > +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> > > > +\begin{itemize}
> > > > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set
> > \field{hash_tunnel_types} for the device using the
> > > > +      virtnet_hash_tunnel_config_set structure, which is read-only for the
> > device.
> > > > +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get
> > \field{hash_tunnel_types} and \field{supported_hash_tunnel_types}
> > > > +      from the device using the virtnet_hash_tunnel_config_get structure,
> > which is write-only for the device.
> > > > +\end{itemize}
> > > > +
> > > > +\subparagraph{Encapsulated packet}
> > > > +\label{sec:Device Types / Network Device / Device Operation /
> > > > +Processing of Incoming Packets / Hash calculation for incoming
> > > > +packets / Encapsulated packet}
> > > > +
> > > > +Multiple tunneling protocols allow encapsulating an inner, payload packet
> > in an outer, encapsulated packet.
> > > > +The encapsulated packet thus contains an outer header and an inner
> > > > +header, and the device calculates the hash over either the inner header or
> > the outer header.
> > > > +
> > > > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received
> > > > +encapsulated packet's outer header matches one of the encapsulation
> > > > +types enabled in \field{hash_tunnel_types}, then the device uses the inner
> > header for hash calculations (only a single level of encapsulation is currently
> > supported).
> > > > +
> > > > +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received packet's
> > > > +(outer) header does not match any types enabled in
> > \field{hash_tunnel_types}, then the device uses the outer header for hash
> > calculations.
> > > > +
> > > > +Initially all encapsulation types are disabled (the value of
> > > > +\field{hash_tunnel_types} is 0) for inner header hash before any
> > VIRTIO_NET_CTRL_HASH_TUNNEL_SET command are sent by the driver.
> > >
> > > Initially (before driver sends VIRTIO_NET_CTRL_HASH_TUNNEL_SET) all
> > > encapsulation types are disabled
> > >
> > 
> > Ok.
> > 
> > > > +
> > > > +Encapsulation types supported/enabled for inner header hash:
> > > > +\begin{itemize}
> > > > +    \item The outer header of the following encapsulation types does not
> > contain the transport protocol:
> > > > +        \begin{enumerate}
> > > > +	    \item \hyperref[intro:ipip]{[IPIP]}: the outer header is over IPv4 and
> > the inner header is over IPv4.
> > > > +	    \item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is over
> > IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > > +	    \item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer header
> > is over IPv4 and the inner header is over IPv4.
> > > > +	    \item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer header
> > is over IPv4 and the inner header is over IPv4.
> > > > +	    \item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer header
> > is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > > +        \end{enumerate}
> > > > +
> > > > +    \item The outer header of the following encapsulation types uses UDP as
> > the transport protocol:
> > > > +        \begin{enumerate}
> > > > +	    \item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is over
> > IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > > +	    \item \hyperref[intro:geneve]{[GENEVE]}: the outer header is over
> > IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > > +	    \item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer header is
> > over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > > +	    \item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the outer
> > header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> > > > +        \end{enumerate}
> > > > +\end{itemize}
> > > > +
> > > > +\subparagraph{Encapsulation types supported/enabled for inner
> > > > +header hash} \label{sec:Device Types / Network Device / Device
> > > > +Operation / Processing of Incoming Packets / Hash calculation for
> > > > +incoming packets / Encapsulation types supported/enabled for inner
> > > > +header hash}
> > > > +
> > > > +Encapsulation types applicable for inner header hash:
> > > > +\begin{lstlisting}
> > > > +The \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0)
> > > > +
> > > > +The \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1)
> > > > +
> > > > +The \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2)
> > > > +
> > > > +The \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} encapsulation
> > type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3)
> > > > +
> > > > +The \hyperref[intro:vxlan]{[VXLAN]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4)
> > > > +
> > > > +The \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5)
> > > > +
> > > > +The \hyperref[intro:geneve]{[GENEVE]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6)
> > > > +
> > > > +The \hyperref[intro:ipip]{[IPIP]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7)
> > > > +
> > > > +The \hyperref[intro:nvgre]{[NVGRE]} encapsulation type:
> > > > +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8)
> > > > +\end{lstlisting}
> > > > +
> > > > +\subparagraph{Advice}
> > > > +Example uses of inner header hash:
> > > > +\begin{itemize}
> > > > +\item Legacy tunneling protocols, lacking outer header entropy, can use
> > RSS with inner header hash to
> > > > +      distribute flows with identical outer but different inner headers across
> > various queues, improving performance.
> > > > +\item Identify an inner flow distributed across multiple outer tunnels.
> > > > +\end{itemize}
> > > > +
> > > > +As using the inner header hash completely discards the outer header
> > > > +entropy, care must be taken if the inner header is controlled by an
> > > > +adversary, as the adversary can then intentionally create configurations
> > with insufficient entropy.
> > > > +
> > > > +Besides disabling inner header hash, mitigations would depend on:
> > > > +\begin{itemize}
> > > > +\item Use a tool with good forwarding performance to keep the receive
> > queue from dropping packets.
> > >
> > > this is quite vague
> > >
> > 
> > Giving too specific advice would be too specific, which we discussed a long time
> > ago.
> > 
> > > > +\item If the QoS (Quality of service) is unavailable, the driver can set
> > \field{hash_tunnel_types} to 0
> > > > +      to disable inner header hash for all encapsulated packets.
> > >
> > > this is precisely disabling
> > 
> > \field{hash_tunnel_types} to 0 disabling inner ?
> > 
> > >
> > > > +\item Perform appropriate QoS before packets consume the receive
> > buffers of the receive queues.
> > >
> > > it is not at all clear how would devices do this.
> > >
> > 
> > The reason we're describing it broadly here is that this is done by devices, which
> > usually know what to do, and can also take actions off-device, such as firewalls
> > off-device, etc.
> > 
> > > > +\end{itemize}
> > >
> > > Oh sorry I didn't complete the sentence :( I suggest dropping above
> > > and having something like:
> > >
> > > 	Besides disabling inner header hash, mitigations would depend on how
> > the
> > > 	hash is used, and the consequences of a successful attack.
> > > 	For example, if the attack causes packet drops, using a deeper queue
> > > 	might be able to mitigate it.
> > 
> > Ok, I got you now!
> > 
> > >
> > >
> > >
> > > > +
> > > > +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types /
> > > > +Network Device / Device Operation / Control Virtqueue / Inner
> > > > +Header Hash}
> > > > +
> > > > +If the (outer) header of the received packet does not match any
> > > > +value
> > >
> > > any encapsulation type
> > 
> > Ok. And 'any bits' instead of 'any value' I think.
> > 
> > >
> > > > enabled in \field{hash_tunnel_types},
> > > > +the device MUST calculate the hash on the outer header.
> > > > +
> > > > +If the device receives an unsupported or unrecognized value for
> > > > +\field{hash_tunnel_types}, it MUST respond to the
> > VIRTIO_NET_CTRL_HASH_TUNNEL_SET command with VIRTIO_NET_ERR.
> > >
> > > let's be specific. if any bits in hash_tunnel_types are not set in
> > > supported_hash_tunnel_types
> > 
> > Ok.
> > 
> > >
> > > > +
> > > > +If the device offers the VIRTIO_NET_F_HASH_TUNNEL feature, it MUST
> > provide the values for \field{supported_hash_tunnel_types}.
> > >
> > > what does this mean even?
> > 
> > When the driver uses the GET command, the device should preferably return
> > the corresponding value..
> > 
> > >
> > > > +
> > > > +If \field{hash_tunnel_types} is set to 0 or upon device reset, the device
> > MUST disable inner header hash for all encapsulation types.
> > > > +
> > > > +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types /
> > > > +Network Device / Device Operation / Control Virtqueue / Inner
> > > > +Header Hash}
> > > > +
> > > > +The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL
> > > > +feature when issuing commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET
> > and VIRTIO_NET_CTRL_HASH_TUNNEL_GET.
> > > > +
> > > > +The driver MUST ignore the values received from the
> > VIRTIO_NET_CTRL_HASH_TUNNEL_GET command if the device responds with
> > VIRTIO_NET_ERR.
> > > > +
> > > > +The driver MUST NOT set any value in \field{hash_tunnel_types} which is
> > not set in \field{supported_hash_tunnel_types}.
> > >
> > > any bits. not any value
> > 
> > Get.
> > 
> > Thanks.
> > 
> > >
> > > > +
> > > >  \paragraph{Hash reporting for incoming packets}  \label{sec:Device
> > > > Types / Network Device / Device Operation / Processing of Incoming
> > > > Packets / Hash reporting for incoming packets}
> > > >
> > > > diff --git a/device-types/net/device-conformance.tex
> > > > b/device-types/net/device-conformance.tex
> > > > index 54f6783..f88f48b 100644
> > > > --- a/device-types/net/device-conformance.tex
> > > > +++ b/device-types/net/device-conformance.tex
> > > > @@ -14,4 +14,5 @@
> > > >  \item \ref{devicenormative:Device Types / Network Device / Device
> > > > Operation / Control Virtqueue / Automatic receive steering in
> > > > multiqueue mode}  \item \ref{devicenormative:Device Types / Network
> > > > Device / Device Operation / Control Virtqueue / Receive-side scaling
> > > > (RSS) / RSS processing}  \item \ref{devicenormative:Device Types /
> > > > Network Device / Device Operation / Control Virtqueue /
> > > > Notifications Coalescing}
> > > > +\item \ref{devicenormative:Device Types / Network Device / Device
> > > > +Operation / Control Virtqueue / Inner Header Hash}
> > > >  \end{itemize}
> > > > diff --git a/device-types/net/driver-conformance.tex
> > > > b/device-types/net/driver-conformance.tex
> > > > index 97d0cc1..9d853d9 100644
> > > > --- a/device-types/net/driver-conformance.tex
> > > > +++ b/device-types/net/driver-conformance.tex
> > > > @@ -14,4 +14,5 @@
> > > >  \item \ref{drivernormative:Device Types / Network Device / Device
> > > > Operation / Control Virtqueue / Offloads State Configuration /
> > > > Setting Offloads State}  \item \ref{drivernormative:Device Types /
> > > > Network Device / Device Operation / Control Virtqueue / Receive-side
> > > > scaling (RSS) }  \item \ref{drivernormative:Device Types / Network
> > > > Device / Device Operation / Control Virtqueue / Notifications
> > > > Coalescing}
> > > > +\item \ref{drivernormative:Device Types / Network Device / Device
> > > > +Operation / Control Virtqueue / Inner Header Hash}
> > > >  \end{itemize}
> > > > diff --git a/introduction.tex b/introduction.tex index
> > > > b7155bf..81f07a4 100644
> > > > --- a/introduction.tex
> > > > +++ b/introduction.tex
> > > > @@ -102,6 +102,45 @@ \section{Normative
> > References}\label{sec:Normative References}
> > > >      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic Cureve
> > Cryptography'', Version 1.0, September 2000.
> > > >  	\newline\url{https://www.secg.org/sec1-v2.pdf}\\
> > > >
> > > > +	\phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
> > > > +    Generic Routing Encapsulation. This protocol is only specified for IPv4
> > and used as either the payload or delivery protocol.
> > > > +	\newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> > > > +	\phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
> > > > +    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}.
> > This protocol describes extensions by which two fields, Key and
> > > > +    Sequence Number, can be optionally carried in the GRE Header
> > \ref{intro:gre_rfc2784}.
> > > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
> > > > +	\phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
> > > > +    IPv6 Support for Generic Routing Encapsulation (GRE). This protocol is
> > specified for IPv6 and used as either the payload or
> > > > +    delivery protocol. Note that this does not change the GRE header format
> > or any behaviors specified by RFC 2784 or RFC 2890.
> > > > +	\newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
> > > > +	\phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-
> > UDP]} &
> > > > +    GRE-in-UDP Encapsulation. This specifies a method of encapsulating
> > network protocol packets within GRE and UDP headers.
> > > > +    This protocol is specified for IPv4 and IPv6, and used as either the
> > payload or delivery protocol.
> > > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
> > > > +	\phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
> > > > +    Virtual eXtensible Local Area Network.
> > > > +	\newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> > > > +	\phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
> > > > +    Generic Protocol Extension for VXLAN. This protocol describes extending
> > Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN
> > header.
> > > > +	\newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxlan-gpe-
> > 12.txt}\\
> > > > +	\phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
> > > > +    Generic Network Virtualization Encapsulation.
> > > > +	\newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
> > > > +	\phantomsection\label{intro:ipip}\textbf{[IPIP]} &
> > > > +    IP Encapsulation within IP.
> > > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
> > > > +	\phantomsection\label{intro:nvgre}\textbf{[NVGRE]} &
> > > > +    NVGRE: Network Virtualization Using Generic Routing Encapsulation
> > > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
> > > > +	\phantomsection\label{intro:IP}\textbf{[IP]} &
> > > > +    INTERNET PROTOCOL
> > > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
> > > > +	\phantomsection\label{intro:UDP}\textbf{[UDP]} &
> > > > +    User Datagram Protocol
> > > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
> > > > +	\phantomsection\label{intro:TCP}\textbf{[TCP]} &
> > > > +    TRANSMISSION CONTROL PROTOCOL
> > > > +	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
> > > >  \end{longtable}
> > > >
> > > >  \section{Non-Normative References}
> > > > --
> > > > 2.19.1.6.gb485710b
> > >
> > >
> > > This publicly archived list offers a means to provide input to the
> > > OASIS Virtual I/O Device (VIRTIO) TC.
> > >
> > > In order to verify user consent to the Feedback License terms and to
> > > minimize spam in the list archive, subscription is required before
> > > posting.
> > >
> > > Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> > > Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> > > List help: virtio-comment-help@lists.oasis-open.org
> > > List archive: https://lists.oasis-open.org/archives/virtio-comment/
> > > Feedback License:
> > > https://www.oasis-open.org/who/ipr/feedback_license.pdf
> > > List Guidelines:
> > > https://www.oasis-open.org/policies-guidelines/mailing-lists
> > > Committee: https://www.oasis-open.org/committees/virtio/
> > > Join OASIS: https://www.oasis-open.org/join/
> 
> This publicly archived list offers a means to provide input to the
> OASIS Virtual I/O Device (VIRTIO) TC.
> 
> In order to verify user consent to the Feedback License terms and
> to minimize spam in the list archive, subscription is required
> before posting.
> 
> Subscribe: virtio-comment-subscribe@lists.oasis-open.org
> Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
> List help: virtio-comment-help@lists.oasis-open.org
> List archive: https://lists.oasis-open.org/archives/virtio-comment/
> Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

