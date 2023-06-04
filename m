Return-Path: <virtio-dev-return-12840-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A172CC7EE29
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:22:15 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id B58767A1CC
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:22:14 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 960F0986332
	for <virtio-dev@archiver.kernel.org>; Sun,  4 Jun 2023 13:22:14 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 7EE909862CE; Sun,  4 Jun 2023 13:22:14 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 67CD09862D0
	for <virtio-dev@lists.oasis-open.org>; Sun,  4 Jun 2023 13:22:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-MC-Unique: XYHAJSjBOuu-lRdB6_Z6UQ-1
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685884931; x=1688476931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fZg8Yxp4DRTPQoaPpXUdeJ1xnNK35YK45WtyVJAl/U=;
        b=UDN99BgBLqY6BfFwQYdd+wljeV2ONfhClIYZ2OrrePhsGbPf6Yk3T6WIqwdN1kzXWE
         +/TyzFkqUk+6Cbby0Byu2wDgjEXmlgFQvydslwKjD/8ldfRuqVHN/Ltt9nUXEpyx16QN
         9xplyW9Ht3Mv7gAHcEdmQ1TZwV+dzcvlsi7izI4rSFdDUGaWEThM9nlXb0F3pfan6By8
         otVB/C3MF6PbooIK5SrMNinBcwGrpJ52t3G5yuZiffUTHLKU0zEXcXX7YqZpm79WrJuz
         J/JEP2esuCnUSM6B735esWGR6C9ZjWBnAsCVR/OV+rKrbXx2eh0pD6jL0xUTX2B6d6iW
         yteA==
X-Gm-Message-State: AC+VfDxYJCdtiBzFNjQ/qM96B2j6at4H/gg5TBEGBY/h4L4G9a1A7Icx
	UgRn0CliPczeWB4804LzMUaB7xvPmgtu2h2JgRc/4c4I4c35KzDrmNqsFpH3r6hRKpWX7T9CbVL
	DuEEUfwEXeU9Cm7kp+vymlzDhAWb7
X-Received: by 2002:a7b:c5d5:0:b0:3f6:1141:7cc1 with SMTP id n21-20020a7bc5d5000000b003f611417cc1mr5744464wmk.26.1685884931003;
        Sun, 04 Jun 2023 06:22:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7ppAwBWCoqG3qzZbZQsZANaV2UoEbXLGR3b/7Hf7cj7qLt4tq7TOl+x9nElBOfuJIo3hMEqw==
X-Received: by 2002:a7b:c5d5:0:b0:3f6:1141:7cc1 with SMTP id n21-20020a7bc5d5000000b003f611417cc1mr5744455wmk.26.1685884930679;
        Sun, 04 Jun 2023 06:22:10 -0700 (PDT)
Date: Sun, 4 Jun 2023 09:22:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Cc: virtio-dev@lists.oasis-open.org, cohuck@redhat.com,
	david.edmondson@oracle.com, sburla@marvell.com, jasowang@redhat.com,
	yishaih@nvidia.com, maorg@nvidia.com,
	virtio-comment@lists.oasis-open.org, shahafs@nvidia.com
Message-ID: <20230604091651-mutt-send-email-mst@kernel.org>
References: <20230602203604.627661-1-parav@nvidia.com>
 <20230602203604.627661-3-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20230602203604.627661-3-parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [virtio-dev] Re: [PATCH v3 2/3] transport-pci: Introduce legacy registers access
 commands

On Fri, Jun 02, 2023 at 11:36:03PM +0300, Parav Pandit wrote:
> +\subsubsection{Legacy Device Registers Read Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Common Configuration Registers Read Command}
> +
> +The Legacy Device Registers Read Command follows \field{struct virtio_admin_cmd}.
> +This command reads legacy device specific registers of a member VF device.
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LD_REG_READ.
> +
> +The command VIRTIO_ADMIN_CMD_LD_REG_READ uses following listed structure for
> +\field{command_specific_data}:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_ld_reg_rd_data {
> +	u8 offset; /* Starting byte offset of the register to read */
> +};
> +\end{lstlisting}
> +
> +When command completes successfully, \field{command_specific_result}
> +uses following listed structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_ld_reg_rd_result {
> +	u8 registers[];
> +};
> +\end{lstlisting}
> +
> +\subsubsection{Legacy Queue Notify Offset Query Command}\label{sec:Virtio Transport Options / Virtio Over PCI Bus / Legacy Interfaces: SR-IOV VFs Registers Access / Legacy Queue Notify Offset Query Command}
> +
> +This command returns the notify offset of the member VF for virtqueue
> +driver notifications. This command follows \field{struct virtio_admin_cmd}.
> +The driver sets command \field{opcode} to VIRTIO_ADMIN_CMD_LQ_NOTIFY_QUERY.
> +There is no command specific data for this command.
> +
> +When command completes successfully, \field{command_specific_result}
> +uses following listed structure:
> +
> +\begin{lstlisting}
> +struct virtio_admin_cmd_lq_notify_query_result {
> +	u8 bar; /* PCI BAR number of the member VF */
> +	u8 reserved[7];
> +	le64 offset; /* Byte offset within the BAR */
> +};
> +\end{lstlisting}
> +
> +The driver that may use the driver notifications region of the VF device
> +returned in this result likely attain higher performance or the drier may use
> +the VIRTIO_ADMIN_CMD_LREG_WRITE command.

Obtain I guess ... but how? There's no explanation.


> +
> +\begin{note}
> +The device and driver must encode and decode legacy device specific registers
> +using little endian format. Per PCI VF device level big endian format support
> +is left for the future.
> +\end{note}
> +
> +\begin{note}
> +The PCI VF device should not use PCI BAR 0 when it prefers to support
> +legacy interface registers access using its group owner PF. This enables
> +hypervisor software to operate with least complexities to compose a legacy
> +interface I/O space BAR and passthrough other PCI BARs and PCI device
> +capabilities to the guest virtual machine without any translation.
> +\end{note}

Is this related to this last command somehow? what does it mean
for PCI VF device to use a BAR? not use a BAR? Prefer what to what?

> -- 
> 2.26.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

