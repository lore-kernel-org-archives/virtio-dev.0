Return-Path: virtio-dev-return-2676-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [66.179.20.138])
	by lists.oasis-open.org (Postfix) with ESMTP id A131B5819124
	for <virtio-dev@lists.oasis-open.org>; Sun, 12 Nov 2017 23:35:37 -0800 (PST)
Message-ID: <5A094ADD.406@huawei.com>
Date: Mon, 13 Nov 2017 15:33:49 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1509951528-30976-1-git-send-email-longpeng2@huawei.com> <1509951528-30976-2-git-send-email-longpeng2@huawei.com> <20171110170237.GA18834@stefanha-x1.localdomain>
In-Reply-To: <20171110170237.GA18834@stefanha-x1.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: [virtio-dev] Re: [Qemu-devel] [v21 RESEND 1/2] virtio-crypto: Add virtio crypto
 device specification
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org, pasic@linux.vnet.ibm.com, Ola.Liljedahl@arm.com, brian.a.keating@intel.com, wangxinxin.wang@huawei.com, mst@redhat.com, xin.zeng@intel.com, jasowang@redhat.com, luonengjun@huawei.com, agraf@suse.de, john.griffin@intel.com, arei.gonglei@huawei.com, liang.j.ma@intel.com, stefanha@redhat.com, jianjay.zhou@huawei.com, cornelia.huck@de.ibm.com, Varun.Sethi@freescale.com, Jani.Kokkonen@huawei.com, vincent.jardin@6wind.com, denglingli@chinamobile.com, weidong.huang@huawei.com
List-ID: <virtio-dev.lists.oasis-open.org>

Hi Stefan,

On 2017/11/11 1:02, Stefan Hajnoczi wrote:

> On Mon, Nov 06, 2017 at 02:58:47PM +0800, Longpeng(Mike) wrote:
>> From: Gonglei <arei.gonglei@huawei.com>
>>
>> The virtio crypto device is a virtual crypto device (ie. hardware
>> crypto accelerator card). Currently, the virtio crypto device provides
>> the following crypto services: CIPHER, MAC, HASH, and AEAD.
>>
>> In this patch, CIPHER, MAC, HASH, AEAD services are introduced.
>>
>> VIRTIO-153
>>
>> Signed-off-by: Gonglei <arei.gonglei@huawei.com>
>> Signed-off-by: Longpeng(Mike) <longpeng2@huawei.com>
> 
> This doesn't build cleanly for me on commit
> 2faf9b0666886abc0ca99f6813446a4e2a04f3ca
> (https://github.com/oasis-tcs/virtio-spec master):
> 
>   $ 
>   $ ./makeall.sh
>   ! LaTeX Error: Lonely \item--perhaps a missing list environment.
> 
> See the LaTeX manual or LaTeX Companion for explanation.
> Type  H <return>  for immediate help.
>  ...
> 
> l.384 \item I
>              f the VIRTIO_CRYPTO_F_MUX_MODE feature bit is NOT negotiated, the
> ?
> 

Ah yes, I'll fix it.

>> diff --git a/acknowledgements.tex b/acknowledgements.tex
>> index 6c86d12..c4b6844 100644
>> --- a/acknowledgements.tex
>> +++ b/acknowledgements.tex
>> @@ -26,6 +26,8 @@ Sasha Levin,	Oracle	\newline
>>  Sergey Tverdyshev,	Thales e-Security	\newline
>>  Stefan Hajnoczi,	Red Hat	\newline
>>  Tom Lyon,	Samya Systems, Inc.	\newline
>> +Lei Gong,	Huawei	\newline
>> +Peng Long,	Huawei	\newline
>>  \end{oasistitlesection}
>>  
>>  The following non-members have provided valuable feedback on this
>> @@ -43,4 +45,5 @@ Laura Novich, Red Hat	\newline
>>  Patrick Durusau,	Technical Advisory Board, OASIS	\newline
>>  Thomas Huth,	IBM	\newline
>>  Yan Vugenfirer, Red Hat / Daynix	\newline
>> +Halil Pasic,	IBM	\newline
>>  \end{oasistitlesection}
> 
> These lists of names are in alphabetical order.  Please insert names at
> the appropriate place.
> 

OK.

>> +If VIRTIO_CRYPTO_F_MUX_MODE is negotioated the device may support both session mode
> 
> s/negotioated/negotiated/

OK. I'll fix some other typos together, thx.

-- 
Regards,
Longpeng(Mike)


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

