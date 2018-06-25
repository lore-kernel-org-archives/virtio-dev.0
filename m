Return-Path: virtio-return-3157-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1529929292-11900-1-git-send-email-pasic@linux.ibm.com>
 <1529929292-11900-2-git-send-email-pasic@linux.ibm.com>
 <20180625164512.720767c5.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.ibm.com>
Date: Mon, 25 Jun 2018 17:15:44 +0200
MIME-Version: 1.0
In-Reply-To: <20180625164512.720767c5.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <327ac53a-3a25-1aa0-c67b-d0930f9615a6@linux.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [PATCH v3 1/6] notifications: unify
 notifications wording in core
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>, Pawel Moll <pawel.moll@arm.com>, Stefan Hajnoczi <stefanha@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 06/25/2018 04:45 PM, Cornelia Huck wrote:
> On Mon, 25 Jun 2018 14:21:27 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
>> Let us unify the wording when talking about notifications. This change
>> establishes the terms available buffer notification for what was usually

[..]

>>   Device reports the number of bytes it has written to memory for
>>   each buffer it uses. This is referred to as ``used length''.
> 
> Unrelated: Device and driver are missing the definite article in some
> places. Might be an idea for an additional patch :)
> 

Yes, there are definitively other things that could be improved. For example
the capitalization in listing:

\begin{itemize}
\item Device status field
\item Feature bits
\item Notifications
\item Device Configuration space

Capital C in *C*onfiguration is most likely wrong.

\item One or more virtqueues
\end{itemize}

Regarding bullet points and capitalization, if the bullet
point is not a sentence but a fragment there seems to be multiple
viable styles. But I'm afraid we aren't consequent across the spec.

Another question is capitalization of 'virtio terms' like Available Ring.
On some occasions we write 'Available Ring' on others 'available ring'.

It would be nice to have a polished document. But for now I will try
to target fragments where the semantics suffers too. (I had another
series that I already presented as RFC but decided to not push in
parallel with this one).


> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
>

Thanks!

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

