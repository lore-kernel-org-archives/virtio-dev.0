Return-Path: virtio-dev-return-7797-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-dev@lists.oasis-open.org>
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id E7A1A98602C
	for <virtio-dev@lists.oasis-open.org>; Fri, 18 Sep 2020 20:25:06 +0000 (UTC)
References: <20200824143708.5664-1-ndragazis@arrikto.com>
 <20200824143708.5664-4-ndragazis@arrikto.com> <87k0wsxszm.fsf@linaro.org>
From: Nikos Dragazis <ndragazis@arrikto.com>
Message-ID: <887dc381-02ba-0fb0-6d9f-34d3ce289a88@arrikto.com>
Date: Fri, 18 Sep 2020 23:24:15 +0300
MIME-Version: 1.0
In-Reply-To: <87k0wsxszm.fsf@linaro.org>
Subject: [virtio-dev] Re: [PATCH 03/11] content: Update list of virtio cfg structures
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: virtio-dev@lists.oasis-open.org, Stefan Hajnoczi <stefanha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 17/9/20 7:34 =CE=BC.=CE=BC., Alex Benn=C3=A9e wrote:

> Nikos Dragazis <ndragazis@arrikto.com> writes:
>
>> Shared memory and vendor-specific configuration structures have been
>> introduced in previous commits.
>>
>> Update the list of virtio configuration structures so that it includes
>> the shared memory and vendor-specific configuration structures.
>>
>> Signed-off-by: Nikos Dragazis <ndragazis@arrikto.com>
>> ---
>>   content.tex | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/content.tex b/content.tex
>> index 3ce768c..b5b2f79 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -634,6 +634,8 @@ \subsection{Virtio Structure PCI Capabilities}\label=
{sec:Virtio Transport Option
>>   \item ISR Status
>>   \item Device-specific configuration (optional)
>>   \item PCI configuration access
>> +\item Shared memory regions (optional)
>> +\item Vendor-specific data (optional)
> Are we talking about "Vendor data capability" here?

Yep.

> Maybe we should call it that?

I would avoid using the word "capability" here because the items in this
list are referred to as "structures". ACK for s/Vendor-specific/Vendor.
In general, I see that the wording in this section is not consistent in
the sense that the terms "configuration structure" and "capability" are
used interchangeably.

>
>>   \end{itemize}
>>  =20
>>   Each structure can be mapped by a Base Address register (BAR) belongin=
g to
>

---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

