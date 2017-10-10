Return-Path: virtio-dev-return-2607-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id 2E4C058190CA
	for <virtio-dev@lists.oasis-open.org>; Tue, 10 Oct 2017 05:19:13 -0700 (PDT)
References: <1506662648-55692-1-git-send-email-longpeng2@huawei.com>
 <1506662648-55692-2-git-send-email-longpeng2@huawei.com>
 <23e444c8-7f23-1021-552e-534153c149dd@linux.vnet.ibm.com>
 <59DCAB16.1000006@huawei.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Tue, 10 Oct 2017 14:18:59 +0200
MIME-Version: 1.0
In-Reply-To: <59DCAB16.1000006@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <090fcde0-453f-98f0-a10d-373fc1595dcf@linux.vnet.ibm.com>
Subject: [virtio-dev] Re: [Qemu-devel] [v20 1/2] virtio-crypto: Add virtio crypto device
 specification
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: virtio-dev@lists.oasis-open.org, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, mst@redhat.com, luonengjun@huawei.com, jasowang@redhat.com, xin.zeng@intel.com, qemu-devel@nongnu.org, agraf@suse.de, mike.caraman@nxp.com, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, john.griffin@intel.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com, arei.gonglei@hotmail.com
List-ID: <virtio-dev.lists.oasis-open.org>



On 10/10/2017 01:12 PM, Longpeng (Mike) wrote:
> 
> 
> On 2017/10/9 23:43, Halil Pasic wrote:
> 
>>
>>
>> On 09/29/2017 07:24 AM, Longpeng(Mike) wrote:
>>> From: Gonglei <arei.gonglei@huawei.com>
>>>
>>> The virtio crypto device is a virtual crypto device (ie. hardware
>>> crypto accelerator card). Currently, the virtio crypto device provides
>>> the following crypto services: CIPHER, MAC, HASH, and AEAD.
>>>
>>> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
>>>
>>> VIRTIO-153
>>>
>>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
>>> ---
>> [..]
>>
>> Continuing basically form where I left of last time to avoid the
>> beginning getting lots of review and the end hardly any.
>>
>>> +\subsubsection{Control Virtqueue}\label{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue}
>>> +
>>> +The driver uses the control virtqueue to send control commands to the
>>> +device, such as session operations (See \ref{sec:Device Types / Crypto Device / Device Operation / Control Virtqueue / Session operation}).
>>> +
>>> +The header for controlq is of the following form:
>>> +\begin{lstlisting}
>>> +#define VIRTIO_CRYPTO_OPCODE(service, op)   (((service) << 8) | (op))
>>> +
>>> +struct virtio_crypto_ctrl_header {
>>> +#define VIRTIO_CRYPTO_CIPHER_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x02)
>>> +#define VIRTIO_CRYPTO_CIPHER_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_CIPHER, 0x03)
>>> +#define VIRTIO_CRYPTO_HASH_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x02)
>>> +#define VIRTIO_CRYPTO_HASH_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_HASH, 0x03)
>>> +#define VIRTIO_CRYPTO_MAC_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x02)
>>> +#define VIRTIO_CRYPTO_MAC_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_MAC, 0x03)
>>> +#define VIRTIO_CRYPTO_AEAD_CREATE_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x02)
>>> +#define VIRTIO_CRYPTO_AEAD_DESTROY_SESSION \
>>> +       VIRTIO_CRYPTO_OPCODE(VIRTIO_CRYPTO_SERVICE_AEAD, 0x03)
>>> +    le32 opcode;
>>> +    /* algo should be service-specific algorithms */
>>> +    le32 algo;
>>> +    le32 flag;
>>> +    /* reserved */
>>> +    le32 queue_id;
>>
>> AFAIR we agreed to drop queue_id. Call the variable something a reserved0,
>> or whatever but not queue_id.
>>
> 
> Oh, yes. 'reserved0' is good enough.
> 
>>> +};
>>> +\end{lstlisting}
>>> +
>>> +The format of the controlq request depends on the VIRTIO_CRYPTO_F_MUX_MODE feature bit:
>>> +
>>> +\begin{itemize*}
>>> +\item If the VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated the controlq request is
>>> +    a fixed-size structure of form:
>>> +\begin{lstlisting}
>>> +struct virtio_crypto_op_ctrl_req {
>>> +    struct virtio_crypto_ctrl_header header;
>>> +
>>> +    union {
>>> +        struct virtio_crypto_sym_create_session_req   sym_create_session;
>>> +        struct virtio_crypto_hash_create_session_req  hash_create_session;
>>> +        struct virtio_crypto_mac_create_session_req   mac_create_session;
>>> +        struct virtio_crypto_aead_create_session_req  aead_create_session;
>>> +        struct virtio_crypto_destroy_session_req      destroy_session;
>>> +    } u;
>>> +};
>>
>>
>> See my comment on your implementation RFC. I don't think we need to
>> introduce these structs.
>>
> 
> Sorry, just virtio_crypto_op_ctrl_req only or all the structs above?

Depends. In the first place I was thinking about virtio_crypto_op_ctrl_req.

> 
> I agree with you that virtio_crypto_op_ctrl_req is unnecessary in the
> implementation, however maybe it's needed in the spec because we just want to
> use it to illustrate the control request format (please see my following reply).
> 
>> The only difference is that a certain portion needs to be padded to 56
>> bytes in case of no-mux and that it does not in case of mux.
>>
> 
> Yes.
> 
>> Furthermore is (struct virtio_crypto_op_ctrl_req) this even correct?
>> Please explain to me, how is an implementer of this specification
>> supposed to know on which offset does the stuff corresponding to struct
>> virtio_crypto_session_input start! Another such question is, what is the
>> size of struct virtio_crypto_op_ctrl_req? (I think I've asked the later
>> one several times, and I'm quite frustrated to do it again -- sorry
>> if I'm wrong, I did not have time to dig trough my emails and verify my
>> hypothesis).
>>
>> IMHO whithout this information it's impossible to come up with an
>> interoperable implementation -- and facilitating that is supposed to be
>> the the main objective of this specification AFAIU.
>>
>> The stuff in the linux header is unambiguous because it has a lot of
>> padding specified which isn't specified here. On the other hand here we
>> have the variable length arrays notation which very ambiguous, and simply
>> does not do the job. Please feel encouraged to point out my mistake
>> if I'm wrong in my assessments (happens quite often -- sadly)!
>>
> 
> Maybe I get your point now, thanks for your patient explanation. :)
> 

You are welcome! If you are in doubt please ask. There is no point
in disusing if you are not pretty sure you got my concern.

Do we agree, that as is is broken and can't be used for a clean-room
implementation (not reversing/looking at another implementation)?

> So...how about (if we introduce struct virtio_crypto_op_ctrl_req in the spec)
> 
> struct virtio_crypto_op_ctrl_req {
>     struct virtio_crypto_ctrl_header header;
> 
> #define VIRTIO_CRYPTO_CTRL_REQ_PARAM_SIZE_NONMUX 56
>     /* additional paramenter */
>     u8 additional_para[VIRTIO_CRYPTO_CTRL_REQ_PARAM_SIZE_NONMUX];
> };
> 
> For mux mode, the request format is:
> struct virtio_crypto_op_ctrl_req_mux {
>     struct virtio_crypto_ctrl_header header;
> 
>     /* additional paramenter */
>     u8 additional_para[addl_para_len];
> };
> 
> 

Can one implement based on that in your opinion? I don't
see it right now.

> If you have some better approaches, please let us know, thanks :)
> 

Maybe. I would have to think and do some research myself.

I suggest come up with a new cleaned up reference implementation
and a portion of the spec describing the messages, which is detailed
and correct enough to be used as a basis for an implementation.

Ask yourself actively. Do I know where each piece of information
needs to know? Where is it written?

When you feel comfortable send the QEMU patches and the v21 of the spec,
and put me on cc. Regarding the QEMU patches also feel free to send
me a preview in private if you feel like it.

If I get the time to think about a better way of describing the
message formats, I will let you know. But I don't want to promise
anything.


Regards,
Halil


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

