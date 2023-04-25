Return-Path: <virtio-dev-return-12418-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E75BC77B61
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 21:06:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 85AD34456A
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 21:06:32 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 79858986642
	for <virtio-dev@archiver.kernel.org>; Tue, 25 Apr 2023 21:06:32 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 5FD8F9865E2; Tue, 25 Apr 2023 21:06:32 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 49A9E986475
	for <virtio-dev@lists.oasis-open.org>; Tue, 25 Apr 2023 21:06:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: aKkKES-wPBmlbrtW4fGMFA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682456788; x=1685048788;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUDFumjd95thRlRqo630D6aVj9xl0tkWyD0xrV3H8fE=;
        b=jJHIkJu+rQJdlq4UvrfFmGiq4NNw25HFUmjRojaVtdffdgCPFoRDz1ZVvaI/9uG9DT
         IknvFVVwoSRj7vkHwPt24u5mASngbBUK0pCnl7/g7ts65TeT05wsWeTug+yK+XYCyrTd
         04RLHecFBKHWvN3HlEqTe1d8sD1B89t+7hZPyPTXpylpTAqk4HUJfMAmK5ClYp+Iz1Pd
         rfBSGQImcgSFVKhHDhMLzn+1NqocjWKVfuwZ/URxZte8N3dpP/fQHVaDUEGnn/fxq+CQ
         6iRl6OS3a+RqcEv/A/Zh+PWK33XCMwsR4NrQFnjRwGkZ845wfvWGZvhqpVgd8mr364De
         CBzA==
X-Gm-Message-State: AC+VfDxSvsvjMQFTHjR44F0Wp3lnT+d1P2ZxZVNZyfhpigKtcUO45+74
	TeieNjOdk4whcY3G0jBPY5qnyd5016bY4o3VdO+qTwYMxqhUuoBVfUJe5i6D73TTzgz47YuPpD2
	K2/BzODONONYPtF5yAcVvOEDU5yImMECyQQ2b
X-Received: by 2002:adf:ff81:0:b0:2d0:58f9:a6b with SMTP id j1-20020adfff81000000b002d058f90a6bmr130631wrr.13.1682456788413;
        Tue, 25 Apr 2023 14:06:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5spnLp/924vyXfZzLv240rwvUqe6r3x15MUXDzkTWakT111LnLfah0qWrreuVF7R6y4y4J7w==
X-Received: by 2002:adf:ff81:0:b0:2d0:58f9:a6b with SMTP id j1-20020adfff81000000b002d058f90a6bmr130618wrr.13.1682456788093;
        Tue, 25 Apr 2023 14:06:28 -0700 (PDT)
Date: Tue, 25 Apr 2023 17:06:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, virtio-dev@lists.oasis-open.org,
	virtio-comment@lists.oasis-open.org,
	Jason Wang <jasowang@redhat.com>,
	Yuri Benditovich <yuri.benditovich@daynix.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Message-ID: <20230425170341-mutt-send-email-mst@kernel.org>
References: <20230423073532.105636-1-hengqi@linux.alibaba.com>
 <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <f9221063-8419-9cb3-e59c-0b0393bdd501@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [virtio-comment] Re: [PATCH v13] virtio-net: support inner
 header hash

On Tue, Apr 25, 2023 at 04:28:33PM -0400, Parav Pandit wrote:
> 
> 
> On 4/23/2023 3:35 AM, Heng Qi wrote:
> >   \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / Network Device / Feature bits / Legacy Interface: Feature bits}
> > @@ -198,6 +202,7 @@ \subsection{Device configuration layout}\label{sec:Device Types / Network Device
> >           u8 rss_max_key_size;
> >           le16 rss_max_indirection_table_length;
> >           le32 supported_hash_types;
> > +        le32 supported_tunnel_hash_types;

this needs a comment explaining it only exists with some
feature bits.

> >   };
> In v12 I was asking this to move to above field from the config area to the
> GET command in comment [1] as,
> 
> "With that no need to define two fields at two different places in config
> area and also in cvq."

I think I disagree.
the proposed design is consistent with regular tunneling.

however I feel we should limit this to 1-2 legacy protocols.
with that, we do not really need a new field at all,
they can fit in supported_hash_types.




> I am sorry if that was not clear enough.
> 
> [1] https://lore.kernel.org/virtio-dev/569cbaf9-f1fb-0e1f-a2ef-b1d7cd7dbb1f@nvidia.com/
> 
> >   \subparagraph{Supported/enabled hash types}
> >   \label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash types}
> > +This paragraph relies on definitions from \hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[intro:TCP]{[TCP]}.
> >   Hash types applicable for IPv4 packets:
> >   \begin{lstlisting}
> >   #define VIRTIO_NET_HASH_TYPE_IPv4              (1 << 0)
> > @@ -980,6 +993,152 @@ \subsubsection{Processing of Incoming Packets}\label{sec:Device Types / Network
> >   (see \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / IPv6 packets without extension header}).
> >   \end{itemize}
> > +\paragraph{Inner Header Hash}
> > +\label{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Inner Header Hash}
> > +
> > +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the device supports inner header hash and the driver can send
> > +commands VIRTIO_NET_CTRL_TUNNEL_HASH_SET and VIRTIO_NET_CTRL_TUNNEL_HASH_GET for the inner header hash configuration.
> > +
> > +struct virtio_net_hash_tunnel_config {
> Please move field from the config struct to here. Both are RO fields.
> 
> le32 supported_hash_tunnel_types;
> > +    le32 hash_tunnel_types;
> > +};
> > +
> > +#define VIRTIO_NET_CTRL_TUNNEL_HASH 7
> > + #define VIRTIO_NET_CTRL_TUNNEL_HASH_SET 0
> > + #define VIRTIO_NET_CTRL_TUNNEL_HASH_GET 1
> > +
> > +Filed \field{hash_tunnel_types} contains a bitmask of configured hash tunnel types as
> > +defined in \ref{sec:Device Types / Network Device / Device Operation / Processing of Incoming Packets / Hash calculation for incoming packets / Supported/enabled hash tunnel types}.
> > +
> > +The class VIRTIO_NET_CTRL_TUNNEL_HASH has the following commands:
> > +\begin{itemize}
> > +\item VIRTIO_NET_CTRL_TUNNEL_HASH_SET: set the \field{hash_tunnel_types} to configure the inner header hash calculation for the device.
> > +\item VIRTIO_NET_CTRL_TUNNEL_HASH_GET: get the \field{hash_tunnel_types} from the device.
> > +\end{itemize}
> > +
> > +For the command VIRTIO_NET_CTRL_TUNNEL_HASH_SET, the structure virtio_net_hash_tunnel_config is write-only for the driver.
> > +For the command VIRTIO_NET_CTRL_TUNNEL_HASH_GET, the structure virtio_net_hash_tunnel_config is read-only for the driver.
> > +
> You need to split the structures to two, one for get and one for set in
> above description as get and set contains different fields.
> > +
> > +If VIRTIO_NET_HASH_TUNNEL_TYPE_NONE is set or the encapsulation type is not included in \field{hash_tunnel_types},
> > +the hash of the outer header is calculated for the received encapsulated packet.
> > +
> > +
> > +For scenarios with sufficient external entropy or no internal hashing requirements, inner header hash may not be needed:
> > +A tunnel is often expected to isolate the external network from the internal one. By completely ignoring entropy
> > +in the external header and replacing it with entropy from the internal header, for hash calculations, this expectation
> You wanted to say inner here like rest of the places.
> 
> s/internal header/inner header
> 
> > +The driver MUST NOT set any VIRTIO_NET_HASH_TUNNEL_TYPE_ flags that are not supported by the device.
> Multiple flags so,
> 
> s/flags that are/flags which are/
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
> 


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

