Return-Path: <virtio-dev-return-13114-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3943CEB64DC
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 03:46:43 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A3643120D6D
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 03:46:42 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9398C98658E
	for <virtio-dev@archiver.kernel.org>; Wed, 28 Jun 2023 03:46:42 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 84C56986551; Wed, 28 Jun 2023 03:46:42 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67CED98654E
	for <virtio-dev@lists.oasis-open.org>; Wed, 28 Jun 2023 03:46:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: llU87PwsPDiSgajGLYEaAA-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687923995; x=1690515995;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/vnQKy55+fVgLByR7d05wVG2cQflypsBPLZaCWKdGIE=;
        b=Fzr5JWFXnuF+lqSEiXI2GrnKBJIzqcl3BUcwRPcXNYNelw80z3QLD57L7qL6GM/cAU
         cLWzEHOcEVNlT0uvXHG4rGnI7DihHXylI60iR1OKKbYFF3sjtIbimncvsZH+VD83ruw5
         oWmvp6XxcQ/GUHAcvcWbzfCkEbOiBl4khM7EPod9spS7TMo/LcZK0u36EcBJd/AMujfH
         h3AI0iVXpCLkieQYjtvcom7ex6WE8bUvtp7ciAq95/XoFgCJIs5Zjm/wtdHuqV4ZCexw
         kuQQkrxmfpbimuxCSLzI8pxgrD3WxE4G/kgc/dIvyKpbolXHznwQS0RRI4u0yNCiZppW
         jTeg==
X-Gm-Message-State: AC+VfDzfPX3GlK/lJ2quB6dpEhmsXGJ1HXcluLXmjIfsakOQsFAGkJoo
	naAZJZVZu4p5gsVuLtcod2Pxql/UGfLKH3fxQjfV/R8tFX/kuRkIdd4Cl8ZtDyh7vG5oPLKReS1
	riIuk0HdSwOAbg3kAacOYmRvrdR8BCTwNi2a/VAn7NLP1
X-Received: by 2002:a05:6512:31cf:b0:4fb:82d8:994f with SMTP id j15-20020a05651231cf00b004fb82d8994fmr3029676lfe.33.1687923994903;
        Tue, 27 Jun 2023 20:46:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6t+Xc9abneFeX/PSjnsqjrJxmkC1eUCPYaJeLjBkxtEFMvhp86OzbRcEdDrGF8KM5BTq7MfqTz1F9UbKH9ciI=
X-Received: by 2002:a05:6512:31cf:b0:4fb:82d8:994f with SMTP id
 j15-20020a05651231cf00b004fb82d8994fmr3029664lfe.33.1687923994334; Tue, 27
 Jun 2023 20:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230627163549.40028-1-hengqi@linux.alibaba.com>
In-Reply-To: <20230627163549.40028-1-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 11:46:22 +0800
Message-ID: <CACGkMEvFmAiWDp8w=ytin21Oi+PcTb1X3Eve7Kt2NVr_RkhgmA@mail.gmail.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	"Michael S . Tsirkin" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>, 
	Yuri Benditovich <yuri.benditovich@daynix.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [PATCH v19] virtio-net: support inner header hash

On Wed, Jun 28, 2023 at 12:35=E2=80=AFAM Heng Qi <hengqi@linux.alibaba.com>=
 wrote:
>
> 1. Currently, a received encapsulated packet has an outer and an inner he=
ader, but
> the virtio device is unable to calculate the hash for the inner header. T=
he same
> flow can traverse through different tunnels, resulting in the encapsulate=
d
> packets being spread across multiple receive queues (refer to the figure =
below).
> However, in certain scenarios, we may need to direct these encapsulated p=
ackets of
> the same flow to a single receive queue. This facilitates the processing
> of the flow by the same CPU to improve performance (warm caches, less loc=
king, etc.).
>
>                client1                    client2
>                   |        +-------+         |
>                   +------->|tunnels|<--------+
>                            +-------+
>                               |  |
>                               v  v
>                       +-----------------+
>                       | monitoring host |
>                       +-----------------+
>
> To achieve this, the device can calculate a symmetric hash based on the i=
nner headers
> of the same flow.
>
> 2. For legacy systems, they may lack entropy fields which modern protocol=
s have in
> the outer header, resulting in multiple flows with the same outer header =
but
> different inner headers being directed to the same receive queue. This re=
sults in
> poor receive performance.
>
> To address this limitation, inner header hash can be used to enable the d=
evice to advertise
> the capability to calculate the hash for the inner packet, regaining bett=
er receive performance.
>
> Fixes: https://github.com/oasis-tcs/virtio-spec/issues/173
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> ---
> v18->v19:
>         1. Have a single structure instead of two. @Michael S . Tsirkin
>         2. Some small rewrites. @Michael S . Tsirkin
>         3. Rebase to master.
>
> v17->v18:
>         1. Some rewording suggestions from Michael (Thanks!).
>         2. Use 0 to disable inner header hash and remove
>            VIRTIO_NET_HASH_TUNNEL_TYPE_NONE.
> v16->v17:
>         1. Some small rewrites. @Parav Pandit
>         2. Add Parav's Reviewed-by tag (Thanks!).
>
> v15->v16:
>         1. Remove the hash_option. In order to delimit the inner header h=
ash and RSS
>            configuration, the ability to configure the outer src udp port=
 hash is given
>            to RSS. This is orthogonal to inner header hash, which will be=
 done in the
>            RSS capability extension topic (considered as an RSS extension=
 together
>            with the symmetric toeplitz hash algorithm, etc.). @Parav Pand=
it @Michael S . Tsirkin
>         2. Fix a 'field' typo. @Parav Pandit
>
> v14->v15:
>         1. Add tunnel hash option suggested by @Michael S . Tsirkin
>         2. Adjust some descriptions.
>
> v13->v14:
>         1. Move supported_hash_tunnel_types from config space into cvq co=
mmand. @Parav Pandit

I may miss some discussions, but this complicates the provisioning a lot.

Having it in the config space, then a type agnostic provisioning
through config space + feature bits just works fine.

If we move it only via cvq, we need device specific provisioning interface.

Thanks


>         2. Rebase to master branch.
>         3. Some minor modifications.
>
> v12->v13:
>         1. Add a GET command for hash_tunnel_types. @Parav Pandit
>         2. Add tunneling protocol explanation. @Jason Wang
>         3. Add comments on some usage scenarios for inner hash.
>
> v11->v12:
>         1. Add a command VIRTIO_NET_CTRL_MQ_TUNNEL_CONFIG.
>         2. Refine the commit log. @Michael S . Tsirkin
>         3. Add some tunnel types.
>
> v10->v11:
>         1. Revise commit log for clarity for readers.
>         2. Some modifications to avoid undefined terms. @Parav Pandit
>         3. Change VIRTIO_NET_F_HASH_TUNNEL dependency. @Parav Pandit
>         4. Add the normative statements. @Parav Pandit
>
> v9->v10:
>         1. Removed hash_report_tunnel related information. @Parav Pandit
>         2. Re-describe the limitations of QoS for tunneling.
>         3. Some clarification.
>
> v8->v9:
>         1. Merge hash_report_tunnel_types into hash_report. @Parav Pandit
>         2. Add tunnel security section. @Michael S . Tsirkin
>         3. Add VIRTIO_NET_F_HASH_REPORT_TUNNEL.
>         4. Fix some typos.
>         5. Add more tunnel types. @Michael S . Tsirkin
>
> v7->v8:
>         1. Add supported_hash_tunnel_types. @Jason Wang, @Parav Pandit
>         2. Change hash_report_tunnel to hash_report_tunnel_types. @Parav =
Pandit
>         3. Removed re-definition for inner packet hashing. @Parav Pandit
>         4. Fix some typos. @Michael S . Tsirkin
>         5. Clarify some sentences. @Michael S . Tsirkin
>
> v6->v7:
>         1. Modify the wording of some sentences for clarity. @Michael S. =
Tsirkin
>         2. Fix some syntax issues. @Michael S. Tsirkin
>
> v5->v6:
>         1. Fix some syntax and capitalization issues. @Michael S. Tsirkin
>         2. Use encapsulated/encaptulation uniformly. @Michael S. Tsirkin
>         3. Move the links to introduction section. @Michael S. Tsirkin
>         4. Clarify some sentences. @Michael S. Tsirkin
>
> v4->v5:
>         1. Clarify some paragraphs. @Cornelia Huck
>         2. Fix the u8 type. @Cornelia Huck
>
> v3->v4:
>         1. Rename VIRTIO_NET_F_HASH_GRE_VXLAN_GENEVE_INNER to VIRTIO_NET_=
F_HASH_TUNNEL. @Jason Wang
>         2. Make things clearer. @Jason Wang @Michael S. Tsirkin
>         3. Keep the possibility to use inner hash for automatic receive s=
teering. @Jason Wang
>         4. Add the "Tunnel packet" paragraph to avoid repeating the GRE e=
tc. many times. @Michael S. Tsirkin
>
> v2->v3:
>         1. Add a feature bit for GRE/VXLAN/GENEVE inner hash. @Jason Wang
>         2. Chang \field{hash_tunnel} to \field{hash_report_tunnel}. @Jaso=
n Wang, @Michael S. Tsirkin
>
> v1->v2:
>         1. Remove the patch for the bitmask fix. @Michael S. Tsirkin
>         2. Clarify some paragraphs. @Jason Wang
>         3. Add \field{hash_tunnel} and VIRTIO_NET_HASH_REPORT_GRE. @Yuri =
Benditovich
>
>  device-types/net/description.tex        | 149 ++++++++++++++++++++++++
>  device-types/net/device-conformance.tex |   1 +
>  device-types/net/driver-conformance.tex |   1 +
>  introduction.tex                        |  39 +++++++
>  4 files changed, 190 insertions(+)
>
> diff --git a/device-types/net/description.tex b/device-types/net/descript=
ion.tex
> index 3030222..4a6f5a2 100644
> --- a/device-types/net/description.tex
> +++ b/device-types/net/description.tex
> @@ -88,6 +88,8 @@ \subsection{Feature bits}\label{sec:Device Types / Netw=
ork Device / Feature bits
>  \item[VIRTIO_NET_F_CTRL_MAC_ADDR(23)] Set MAC address through control
>      channel.
>
> +\item[VIRTIO_NET_F_HASH_TUNNEL(51)] Device supports inner header hash fo=
r encapsulated packets.
> +
>  \item[VIRTIO_NET_F_VQ_NOTF_COAL(52)] Device supports virtqueue notificat=
ion coalescing.
>
>  \item[VIRTIO_NET_F_NOTF_COAL(53)] Device supports notifications coalesci=
ng.
> @@ -147,6 +149,7 @@ \subsubsection{Feature bit requirements}\label{sec:De=
vice Types / Network Device
>  \item[VIRTIO_NET_F_RSC_EXT] Requires VIRTIO_NET_F_HOST_TSO4 or VIRTIO_NE=
T_F_HOST_TSO6.
>  \item[VIRTIO_NET_F_RSS] Requires VIRTIO_NET_F_CTRL_VQ.
>  \item[VIRTIO_NET_F_VQ_NOTF_COAL] Requires VIRTIO_NET_F_CTRL_VQ.
> +\item[VIRTIO_NET_F_HASH_TUNNEL] Requires VIRTIO_NET_F_CTRL_VQ along with=
 VIRTIO_NET_F_RSS or VIRTIO_NET_F_HASH_REPORT.
>  \end{description}
>
>  \subsubsection{Legacy Interface: Feature bits}\label{sec:Device Types / =
Network Device / Feature bits / Legacy Interface: Feature bits}
> @@ -869,6 +872,8 @@ \subsubsection{Processing of Incoming Packets}\label{=
sec:Device Types / Network
>  If the feature VIRTIO_NET_F_RSS was negotiated:
>  \begin{itemize}
>  \item The device uses \field{hash_types} of the virtio_net_rss_config st=
ructure as 'Enabled hash types' bitmask.
> +\item If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiate=
d, the device uses \field{enabled_tunnel_types} of the
> +      virtnet_hash_tunnel structure as 'Encapsulation types enabled for =
inner header hash' bitmask.
>  \item The device uses a key as defined in \field{hash_key_data} and \fie=
ld{hash_key_length} of the virtio_net_rss_config structure (see
>  \ref{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Receive-side scaling (RSS) / Setting RSS parameters}).
>  \end{itemize}
> @@ -876,6 +881,8 @@ \subsubsection{Processing of Incoming Packets}\label{=
sec:Device Types / Network
>  If the feature VIRTIO_NET_F_RSS was not negotiated:
>  \begin{itemize}
>  \item The device uses \field{hash_types} of the virtio_net_hash_config s=
tructure as 'Enabled hash types' bitmask.
> +\item If additionally the feature VIRTIO_NET_F_HASH_TUNNEL was negotiate=
d, the device uses \field{enabled_tunnel_types} of the
> +      virtnet_hash_tunnel structure as 'Encapsulation types enabled for =
inner header hash' bitmask.
>  \item The device uses a key as defined in \field{hash_key_data} and \fie=
ld{hash_key_length} of the virtio_net_hash_config structure (see
>  \ref{sec:Device Types / Network Device / Device Operation / Control Virt=
queue / Automatic receive steering in multiqueue mode / Hash calculation}).
>  \end{itemize}
> @@ -889,6 +896,9 @@ \subsubsection{Processing of Incoming Packets}\label{=
sec:Device Types / Network
>   \ref{sec:Device Types / Network Device / Device Operation / Control Vir=
tqueue / Automatic receive steering in multiqueue mode / Hash calculation}.
>  \end{itemize}
>
> +The per-packet hash calculation can depend on the IP packet type. See
> +\hyperref[intro:IP]{[IP]}, \hyperref[intro:UDP]{[UDP]} and \hyperref[int=
ro:TCP]{[TCP]}.
> +
>  \subparagraph{Supported/enabled hash types}
>  \label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Supported/en=
abled hash types}
>  Hash types applicable for IPv4 packets:
> @@ -1001,6 +1011,145 @@ \subsubsection{Processing of Incoming Packets}\la=
bel{sec:Device Types / Network
>  (see \ref{sec:Device Types / Network Device / Device Operation / Process=
ing of Incoming Packets / Hash calculation for incoming packets / IPv6 pack=
ets without extension header}).
>  \end{itemize}
>
> +\paragraph{Inner Header Hash}
> +\label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Inner Header Hash}
> +
> +If VIRTIO_NET_F_HASH_TUNNEL has been negotiated, the driver can send com=
mands VIRTIO_NET_CTRL_HASH_TUNNEL_SET
> +and VIRTIO_NET_CTRL_HASH_TUNNEL_GET to configure the calculation of the =
inner header hash.
> +
> +struct virtnet_hash_tunnel {
> +    le32 supported_tunnel_types;
> +    le32 enabled_tunnel_types;
> +};
> +
> +#define VIRTIO_NET_CTRL_HASH_TUNNEL 7
> + #define VIRTIO_NET_CTRL_HASH_TUNNEL_SET 0
> + #define VIRTIO_NET_CTRL_HASH_TUNNEL_GET 1
> +
> +The class VIRTIO_NET_CTRL_HASH_TUNNEL has the following commands:
> +\begin{itemize}
> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_SET: set \field{enabled_tunnel_types} =
for the device using the
> +      virtnet_hash_tunnel structure, which is read-only for the device.
> +      Field \field{supported_tunnel_types} is reserved and it is ignored=
 by the device.
> +      Field \field{enabled_tunnel_types} contains the bitmask of encapsu=
lation types to enable for inner header hash.
> +
> +\item VIRTIO_NET_CTRL_HASH_TUNNEL_GET: get \field{enabled_tunnel_types} =
and \field{supported_tunnel_types} from
> +      the device using the virtnet_hash_tunnel structure, which is write=
-only for the device.
> +      Field \field{supported_tunnel_types} contains the bitmask of encap=
sulation types supported by the device for inner header hash.
> +      Field \field{enabled_tunnel_types} contains the bitmask of encapsu=
lation types enabled in a previous
> +      successful call to VIRTIO_NET_CTRL_HASH_TUNNEL_SET.
> +\end{itemize}
> +
> +Encapsulation types are defined in \ref{sec:Device Types / Network Devic=
e / Device Operation / Processing of Incoming Packets /
> +Hash calculation for incoming packets / Encapsulation types supported/en=
abled for inner header hash}.
> +
> +\subparagraph{Encapsulated packet}
> +\label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash calculation for incoming packets / Encapsulated=
 packet}
> +
> +Multiple tunneling protocols allow encapsulating an inner, payload packe=
t in an outer, encapsulated packet.
> +The encapsulated packet thus contains an outer header and an inner heade=
r, and the device calculates the
> +hash over either the inner header or the outer header.
> +
> +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received encapsulated pa=
cket's outer header matches one of the
> +encapsulation types enabled in \field{enabled_tunnel_types}, then the de=
vice uses the inner header for hash
> +calculations (only a single level of encapsulation is currently supporte=
d).
> +
> +If VIRTIO_NET_F_HASH_TUNNEL is negotiated and a received packet's (outer=
) header does not match any encapsulation
> +types enabled in \field{enabled_tunnel_types}, then the device uses the =
outer header for hash calculations.
> +
> +Initially (before the driver sends any VIRTIO_NET_CTRL_HASH_TUNNEL_SET c=
ommand) all encapsulation types are
> +disabled (the value of \field{enabled_tunnel_types} is 0) for inner head=
er hash.
> +
> +Encapsulation types supported/enabled for inner header hash:
> +\begin{itemize}
> +    \item The outer header of the following encapsulation types does not=
 contain the transport protocol:
> +        \begin{enumerate}
> +           \item \hyperref[intro:ipip]{[IPIP]}: the outer header is over=
 IPv4 and the inner header is over IPv4.
> +           \item \hyperref[intro:nvgre]{[NVGRE]}: the outer header is ov=
er IPv4/IPv6 and the inner header is over IPv4/IPv6.
> +           \item \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]}: the outer =
header is over IPv4 and the inner header is over IPv4.
> +           \item \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]}: the outer =
header is over IPv4 and the inner header is over IPv4.
> +           \item \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]}: the outer =
header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> +        \end{enumerate}
> +
> +    \item The outer header of the following encapsulation types uses UDP=
 as the transport protocol:
> +        \begin{enumerate}
> +           \item \hyperref[intro:vxlan]{[VXLAN]}: the outer header is ov=
er IPv4/IPv6 and the inner header is over IPv4/IPv6.
> +           \item \hyperref[intro:geneve]{[GENEVE]}: the outer header is =
over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> +           \item \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]}: the outer head=
er is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> +           \item \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]}: the =
outer header is over IPv4/IPv6 and the inner header is over IPv4/IPv6.
> +        \end{enumerate}
> +\end{itemize}
> +
> +\subparagraph{Encapsulation types supported/enabled for inner header has=
h}
> +\label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets /
> +Hash calculation for incoming packets / Encapsulation types supported/en=
abled for inner header hash}
> +
> +Encapsulation types applicable for inner header hash:
> +\begin{lstlisting}
> +The \hyperref[intro:gre_rfc2784]{[GRE_rfc2784]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2784    (1 << 0)
> +
> +The \hyperref[intro:gre_rfc2890]{[GRE_rfc2890]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_2890    (1 << 1)
> +
> +The \hyperref[intro:gre_rfc7676]{[GRE_rfc7676]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_7676    (1 << 2)
> +
> +The \hyperref[intro:gre_in_udp_rfc8086]{[GRE-in-UDP]} encapsulation type=
:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GRE_UDP     (1 << 3)
> +
> +The \hyperref[intro:vxlan]{[VXLAN]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN       (1 << 4)
> +
> +The \hyperref[intro:vxlan_gpe]{[VXLAN-GPE]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_VXLAN_GPE   (1 << 5)
> +
> +The \hyperref[intro:geneve]{[GENEVE]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_GENEVE      (1 << 6)
> +
> +The \hyperref[intro:ipip]{[IPIP]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_IPIP        (1 << 7)
> +
> +The \hyperref[intro:nvgre]{[NVGRE]} encapsulation type:
> +#define VIRTIO_NET_HASH_TUNNEL_TYPE_NVGRE       (1 << 8)
> +\end{lstlisting}
> +
> +\subparagraph{Advice}
> +Example uses of inner header hash:
> +\begin{itemize}
> +\item Legacy tunneling protocols, lacking outer header entropy, can use =
RSS with inner header hash to
> +      distribute flows with identical outer but different inner headers =
across various queues, improving performance.
> +\item Identify an inner flow distributed across multiple outer tunnels.
> +\end{itemize}
> +
> +As using inner header hash completely discards the outer header entropy,=
 care must be taken
> +if the inner header is controlled by an adversary, as the adversary can =
then intentionally create
> +configurations with insufficient entropy.
> +
> +Besides disabling inner header hash, mitigations would depend on how the=
 hash is used. When the hash
> +use is limited to RSS queue selection, inner header hash may have qualit=
y of service (QoS) limitations.
> +
> +\devicenormative{\subparagraph}{Inner Header Hash}{Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +
> +The device MUST ignore \field{supported_tunnel_types} for any received V=
IRTIO_NET_CTRL_HASH_TUNNEL_SET command.
> +
> +If the (outer) header of the received packet does not match any encapsul=
ation type enabled
> +in \field{enabled_tunnel_types}, the device MUST calculate the hash on t=
he outer header.
> +
> +If the device receives any bits in \field{enabled_tunnel_types} which ar=
e not set in \field{supported_tunnel_types},
> +it MUST respond to the VIRTIO_NET_CTRL_HASH_TUNNEL_SET command with VIRT=
IO_NET_ERR.
> +
> +If \field{enabled_tunnel_types} is set to 0 or upon device reset, the de=
vice MUST disable inner header hash for all encapsulation types.
> +
> +\drivernormative{\subparagraph}{Inner Header Hash}{Device Types / Networ=
k Device / Device Operation / Control Virtqueue / Inner Header Hash}
> +
> +The driver MUST have negotiated the VIRTIO_NET_F_HASH_TUNNEL feature whe=
n issuing
> +commands VIRTIO_NET_CTRL_HASH_TUNNEL_SET and VIRTIO_NET_CTRL_HASH_TUNNEL=
_GET.
> +
> +The driver MUST ignore the values received from the VIRTIO_NET_CTRL_HASH=
_TUNNEL_GET command if the device responds with VIRTIO_NET_ERR.
> +
> +The driver MUST NOT set any bits in \field{enabled_tunnel_types} which i=
s not set in \field{supported_tunnel_types}.
> +
>  \paragraph{Hash reporting for incoming packets}
>  \label{sec:Device Types / Network Device / Device Operation / Processing=
 of Incoming Packets / Hash reporting for incoming packets}
>
> diff --git a/device-types/net/device-conformance.tex b/device-types/net/d=
evice-conformance.tex
> index 54f6783..f88f48b 100644
> --- a/device-types/net/device-conformance.tex
> +++ b/device-types/net/device-conformance.tex
> @@ -14,4 +14,5 @@
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Automatic receive steering in multiqueue mode}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Receive-side scaling (RSS) / RSS processing}
>  \item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Notifications Coalescing}
> +\item \ref{devicenormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Inner Header Hash}
>  \end{itemize}
> diff --git a/device-types/net/driver-conformance.tex b/device-types/net/d=
river-conformance.tex
> index 97d0cc1..9d853d9 100644
> --- a/device-types/net/driver-conformance.tex
> +++ b/device-types/net/driver-conformance.tex
> @@ -14,4 +14,5 @@
>  \item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Offloads State Configuration / Setting Offloads S=
tate}
>  \item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Receive-side scaling (RSS) }
>  \item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Notifications Coalescing}
> +\item \ref{drivernormative:Device Types / Network Device / Device Operat=
ion / Control Virtqueue / Inner Header Hash}
>  \end{itemize}
> diff --git a/introduction.tex b/introduction.tex
> index b7155bf..81f07a4 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -102,6 +102,45 @@ \section{Normative References}\label{sec:Normative R=
eferences}
>      Standards for Efficient Cryptography Group(SECG), ``SEC1: Elliptic C=
ureve Cryptography'', Version 1.0, September 2000.
>         \newline\url{https://www.secg.org/sec1-v2.pdf}\\
>
> +       \phantomsection\label{intro:gre_rfc2784}\textbf{[GRE_rfc2784]} &
> +    Generic Routing Encapsulation. This protocol is only specified for I=
Pv4 and used as either the payload or delivery protocol.
> +       \newline\url{https://datatracker.ietf.org/doc/rfc2784/}\\
> +       \phantomsection\label{intro:gre_rfc2890}\textbf{[GRE_rfc2890]} &
> +    Key and Sequence Number Extensions to GRE \ref{intro:gre_rfc2784}. T=
his protocol describes extensions by which two fields, Key and
> +    Sequence Number, can be optionally carried in the GRE Header \ref{in=
tro:gre_rfc2784}.
> +       \newline\url{https://www.rfc-editor.org/rfc/rfc2890}\\
> +       \phantomsection\label{intro:gre_rfc7676}\textbf{[GRE_rfc7676]} &
> +    IPv6 Support for Generic Routing Encapsulation (GRE). This protocol =
is specified for IPv6 and used as either the payload or
> +    delivery protocol. Note that this does not change the GRE header for=
mat or any behaviors specified by RFC 2784 or RFC 2890.
> +       \newline\url{https://datatracker.ietf.org/doc/rfc7676/}\\
> +       \phantomsection\label{intro:gre_in_udp_rfc8086}\textbf{[GRE-in-UD=
P]} &
> +    GRE-in-UDP Encapsulation. This specifies a method of encapsulating n=
etwork protocol packets within GRE and UDP headers.
> +    This protocol is specified for IPv4 and IPv6, and used as either the=
 payload or delivery protocol.
> +       \newline\url{https://www.rfc-editor.org/rfc/rfc8086}\\
> +       \phantomsection\label{intro:vxlan}\textbf{[VXLAN]} &
> +    Virtual eXtensible Local Area Network.
> +       \newline\url{https://datatracker.ietf.org/doc/rfc7348/}\\
> +       \phantomsection\label{intro:vxlan-gpe}\textbf{[VXLAN-GPE]} &
> +    Generic Protocol Extension for VXLAN. This protocol describes extend=
ing Virtual eXtensible Local Area Network (VXLAN) via changes to the VXLAN =
header.
> +       \newline\url{https://www.ietf.org/archive/id/draft-ietf-nvo3-vxla=
n-gpe-12.txt}\\
> +       \phantomsection\label{intro:geneve}\textbf{[GENEVE]} &
> +    Generic Network Virtualization Encapsulation.
> +       \newline\url{https://datatracker.ietf.org/doc/rfc8926/}\\
> +       \phantomsection\label{intro:ipip}\textbf{[IPIP]} &
> +    IP Encapsulation within IP.
> +       \newline\url{https://www.rfc-editor.org/rfc/rfc2003}\\
> +       \phantomsection\label{intro:nvgre}\textbf{[NVGRE]} &
> +    NVGRE: Network Virtualization Using Generic Routing Encapsulation
> +       \newline\url{https://www.rfc-editor.org/rfc/rfc7637.html}\\
> +       \phantomsection\label{intro:IP}\textbf{[IP]} &
> +    INTERNET PROTOCOL
> +       \newline\url{https://www.rfc-editor.org/rfc/rfc791}\\
> +       \phantomsection\label{intro:UDP}\textbf{[UDP]} &
> +    User Datagram Protocol
> +       \newline\url{https://www.rfc-editor.org/rfc/rfc768}\\
> +       \phantomsection\label{intro:TCP}\textbf{[TCP]} &
> +    TRANSMISSION CONTROL PROTOCOL
> +       \newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>  \end{longtable}
>
>  \section{Non-Normative References}
> --
> 2.19.1.6.gb485710b
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

