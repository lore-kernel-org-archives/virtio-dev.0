Return-Path: virtio-dev-return-2770-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 403F15819115
	for <virtio-dev@lists.oasis-open.org>; Wed,  6 Dec 2017 03:01:43 -0800 (PST)
References: <1512545840-10256-1-git-send-email-longpeng2@huawei.com>
 <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 6 Dec 2017 12:01:27 +0100
MIME-Version: 1.0
In-Reply-To: <1512545840-10256-2-git-send-email-longpeng2@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <0209e49f-3d81-cbc9-eb07-13654a288a22@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [v22 1/2] virtio-crypto: Add virtio crypto device
 specification
To: "Longpeng(Mike)" <longpeng2@huawei.com>, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: luonengjun@huawei.com, mst@redhat.com, cornelia.huck@de.ibm.com, stefanha@redhat.com, denglingli@chinamobile.com, Jani.Kokkonen@huawei.com, Ola.Liljedahl@arm.com, Varun.Sethi@freescale.com, xin.zeng@intel.com, brian.a.keating@intel.com, liang.j.ma@intel.com, john.griffin@intel.com, weidong.huang@huawei.com, agraf@suse.de, jasowang@redhat.com, vincent.jardin@6wind.com, arei.gonglei@huawei.com, wangxinxin.wang@huawei.com, jianjay.zhou@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 12/06/2017 08:37 AM, Longpeng(Mike) wrote:
> +\field{outcome_len} is the size of struct virtio_crypto_session_input or
> +ZERO for the session-destroy operation.

This ain't correct. It should have been something like virtio_crypto_destroy_session_input.

> +
> +
> +\paragraph{Session operation}\label{sec:Device Types / Crypto Device / Device
> +Operation / Control Virtqueue / Session operation}
> +
> +The session is a handle which describes the cryptographic parameters to be
> +applied to a number of buffers.
> +
> +The following structure stores the result of session creation set by the device:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_session_input {
> +    /* Device write only portion */
> +    le64 session_id;
> +    le32 status;
> +    le32 padding;
> +};
> +\end{lstlisting}
> +
> +A request to destroy a session includes the following information:
> +
> +\begin{lstlisting}
> +struct virtio_crypto_destroy_session_flf {
> +    /* Device read only portion */
> +    le64  session_id;
> +    /* Device write only portion */

This is the device writable portion and thus what we cal op_outcome above.
So it should have been
};


struct virtio_crypto_destroy_session_input {
> +    le32  status;
> +    le32  padding;
> +};

If we aren't consistent about it the dividing into parts (like op specific
fixed and variable length (output) fields, operation outcome (input))
isn't really helpful.


Regards,
Halil
> +\end{lstlisting}


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

