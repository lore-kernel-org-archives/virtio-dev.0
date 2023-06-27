Return-Path: <virtio-dev-return-13097-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8582EB64DC
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:08:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 45A44C8DEE
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:08:54 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3117A986415
	for <virtio-dev@archiver.kernel.org>; Tue, 27 Jun 2023 08:08:54 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 2495E9843C5; Tue, 27 Jun 2023 08:08:54 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 1141A98635C
	for <virtio-dev@lists.oasis-open.org>; Tue, 27 Jun 2023 08:08:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: qSNtFiF1MaaEpZLMWiJkDw-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687853330; x=1690445330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rL/759AaPMH0st9GXVcOOnv/nZ/V/khCTZbNkw/HAw0=;
        b=ekJ8LWZOwP//rduAWCtO2Y2Q2di6d0kZCrcHi/7C57bslJQIEh92EXDWG3VI9uwTqc
         58ybkD2NC7tjj0aeQRycqzB/0S5LFuU0iUPbe/20TNrIjTZWKn/X5OHv/4jxfrXKLlJJ
         ULutyUdDCmPOvoznB1YIuIud3R/L0qk7s5elf2XMPaTjoXswl9qwwVTmyYssJ/Un/1yV
         LOD5Q8oTdek8UE6EF4CaAfHyZ7UQuXnB+6livd967e1/QHHgLcr5tvwDsza5OdvPQRIk
         L/ZyiS/nYE0nQz6R37gBjTfAmxEErp1t77Lu/LX69bNHaXVSI4UnQwCbgAA6voMXhueu
         ykwg==
X-Gm-Message-State: AC+VfDxQDTVWVp32nV8JGqcZFvxEpAIpfTSpMToDUWfBmpn8roo92enF
	hExPM4TwSVA+74CvujdgW7lY+xOHHbJZgeQZqKvlytiD4+5jhXmQZ2FcAyFkL6DL919IpYSK3Wf
	HUGJLNIHhlr6jtXEgm7+6KXE/eG//S8jK1aovLCETtU3f
X-Received: by 2002:a2e:9d10:0:b0:2b5:7f93:b3b0 with SMTP id t16-20020a2e9d10000000b002b57f93b3b0mr13105362lji.17.1687853329779;
        Tue, 27 Jun 2023 01:08:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4CBowdqVjKy99Rf2VFemax8Aih0a0S4pAsIgVfUcvF64ji64Awo1dZ2FjgSHSu5ws/A8B3dW030rOM7CTivrQ=
X-Received: by 2002:a2e:9d10:0:b0:2b5:7f93:b3b0 with SMTP id
 t16-20020a2e9d10000000b002b57f93b3b0mr13105343lji.17.1687853329451; Tue, 27
 Jun 2023 01:08:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230626062210.49020-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Jun 2023 16:08:38 +0800
Message-ID: <CACGkMEt=zfQn9ZY466opvwJNxamoj8fr=tSP4dQQFAFXymrwXA@mail.gmail.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, 
	mst@redhat.com, parav@nvidia.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [virtio-dev] Re: [virtio-comment] [RFC PATCH] admin-queue: bind the group member
 to the device

On Mon, Jun 26, 2023 at 2:22=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> The VFs of the SR-IOV are created by the user inside the guest OS, so the=
 virtio
> devices don't know about these VFs. Because each VF may be assigned a dif=
ferent role
> by the user, the virtio device can not choose one VF to bind random.
> So only the user knows how to bind the virtio devices to the VFs.
> On the other hand, generally the virtio devices are not created by the us=
er
> inside the guest OS. This requires some management platform to participat=
e.
>
> So the usage of this command:
> 1. The user purchases a virtio network card on the management platform,
>    and sets the ip, queue number, etc. The user obtains the identity of
>    the network card.

Any reason we can't do this through IPC of software layers?

Thanks

> 2. The user creates a VF with echo 8 > sriov_numvfs
> 3. The user binds the net crad to a VF with identity through the command
>    of the patch
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  admin.tex | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>
> diff --git a/admin.tex b/admin.tex
> index 2efd4d7..64d0667 100644
> --- a/admin.tex
> +++ b/admin.tex
> @@ -115,7 +115,8 @@ \subsection{Group administration commands}\label{sec:=
Basic Facilities of a Virti
>  \hline \hline
>  0x0000 & VIRTIO_ADMIN_CMD_LIST_QUERY & Provides to driver list of comman=
ds supported for this group type    \\
>  0x0001 & VIRTIO_ADMIN_CMD_LIST_USE & Provides to device list of commands=
 used for this group type \\
> -0x0002 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    =
\\
> +0x0002 & VIRTIO_ADMIN_CMD_BIND_DEVICE & Bind the device to one group mem=
ber \\
> +0x0003 - 0x7FFF & - & Commands using \field{struct virtio_admin_cmd}    =
\\
>  \hline
>  0x8000 - 0xFFFF & - & Reserved for future commands (possibly using a dif=
ferent structure)    \\
>  \hline
> @@ -429,6 +430,44 @@ \subsection{Group administration commands}\label{sec=
:Basic Facilities of a Virti
>  \field{VF Enable} refer to registers within the SR-IOV Extended
>  Capability as specified by \hyperref[intro:PCIe]{[PCIe]}.
>
> +\subsubsection{Bind the device for member}
> +
> +The VFs of the SR-IOV are created by the user inside the guest OS, so th=
e virtio
> +devices don't know about these VFs. Because each VF may be assigned a di=
fferent role
> +by the user, the virtio device can not choose one VF to bind random.
> +So only the user knows how to bind the virtio devices to the VFs.
> +On the other hand, generally the virtio devices are not created by the u=
ser
> +inside the guest OS. This requires some management platform to participa=
te.
> +
> +So we introduce a new admin queue command to bind the VFs and the virtio
> +devices.
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_bind {
> +    u64 identity;
> +};
> +\end{lstlisting}
> +
> +The user got the \field{identity} from the management platform, that is =
not
> +included by this spec.
> +
> +\drivernormative{\paragraph}{Group administration commands}{Basic Facili=
ties of a Virtio Device / Device groups / Group administration commands / B=
ind the device for member}
> +
> +VIRTIO_ADMIN_CMD_BIND_DEVICE requires that the \field{group_member_id} M=
UST be set.
> +
> +The \field{identity} is passed by the user. It is the identity of the vi=
rtio
> +device.
> +
> +\devicenormative{\paragraph}{Group administration commands}{Basic Facili=
ties of a Virtio Device / Device groups / Group administration commands / B=
ind the device for member}
> +
> +Every device MUST have one unique \field{identity} in the host.
> +
> +If the PF device can not find the device by the \field{identity},
> +the \field{status} MUST be set to VIRTIO_ADMIN_STATUS_EINVAL.
> +
> +If the device is found by the \field{identity}, the device MUST work as =
the
> +device of this group member specified by the \field{group_member_id}.
> +
>  \section{Administration Virtqueues}\label{sec:Basic Facilities of a Virt=
io Device / Administration Virtqueues}
>
>  An administration virtqueue of an owner device is used to submit
> --
> 2.32.0.3.g01195cf9f
>
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
> List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-l=
ists
> Committee: https://www.oasis-open.org/committees/virtio/
> Join OASIS: https://www.oasis-open.org/join/
>


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

