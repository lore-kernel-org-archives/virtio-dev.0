Return-Path: virtio-return-3072-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523398287-25480-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523398287-25480-4-git-send-email-pasic@linux.vnet.ibm.com>
 <20180411095018.61b0caed.cohuck@redhat.com>
From: Halil Pasic <pasic@linux.vnet.ibm.com>
Date: Wed, 11 Apr 2018 15:42:34 +0200
MIME-Version: 1.0
In-Reply-To: <20180411095018.61b0caed.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <82689e84-227f-38d2-713a-b81ef8e1dc1e@linux.vnet.ibm.com>
Subject: [virtio] Re: [virtio-dev] Re: [RFC PATCH 3/3] ccw: map common notifications
 terminology to ccw
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>



On 04/11/2018 09:50 AM, Cornelia Huck wrote:
> On Wed, 11 Apr 2018 00:11:27 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> [Have not yet looked at your other patches, on my list.]
> 
>> The various notifications are introduced and specified in the common
>> (i.e. transport agnostic) portion of this specification. How
>> notifications are realised for a given transport is something each
>> transport has to specify.
>>
>> Let's make the relationship between the virtio-ccw terms and the common
>> terms more obvious.
>>
>> Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> ---
>>  content.tex |   41 +++++++++++++++++++++++++++++++++++++++++
>>  1 files changed, 41 insertions(+), 0 deletions(-)
>>
>> diff --git a/content.tex b/content.tex
>> index 87cc0e2..27aa17b 100644
>> --- a/content.tex
>> +++ b/content.tex
>> @@ -1938,6 +1938,17 @@ Bytes & Description & Contents \\
>>  \hline
>>  \end{tabular}
>>  
>> +A virtio-ccw proxy device facilitates:
>> +\begin{itemize} 
>> +\item Discovery and attachment of  virtio devices (as described above).
>> +\item Initialization of vitqueues and transport specific facilities (using
> 
> s/vitqueues/virtqueues/
> 

Will do.

>> +      custom channel commands).
> 
> s/custom/virtio-specific/ ?

I think it's better -- more formal.

> 
> In a sense, all channel commands other than the basic ones are
> 'custom' :) They are always device or control unit type specific, only
> obeying some rules.
> 

Agree. So custom is in that sense accurate, but virtio-specific rings
nicer.

>> +\item Notifications (via hypercall and virtual interrupts).
> 
> Why 'virtual' interrupts? Better call this 'I/O interrupts' (includes
> both classic and adapter interrupts)?
> 

The idea was 'hypercall' and 'virtual' should harmonize well. These
I/O interrupts are kind of 'real' from the perspective of the virtual
machine, but are 'virtual' from the perspective of HW and AR perspective. 

What I mean, there is AFAIU no way to implement a control unit
and device combo in HW attach it to a z box and do virtio over CIO
naively.

Even with classic I/O interrupts we have to do set indicator + inject
subchannel interrupt to realize a notification. This is however
form core perspective one notification/even/interrupt.

So this is why I added this 'virtual' (to hint it may not fit anything
one can find in the PoP perfectly).

>> +\end{itemize} 
>> +
>> +\subsubsection{Channel Commands for Virtio}\label{sec:Virtio Transport Options / Virtio
>> +over channel I/O / Basic Concepts/ Channel Commands for Virtio}
>> +
>>  In addition to the basic channel commands, virtio-ccw defines a
>>  set of channel commands related to configuration and operation of
>>  virtio:
>> @@ -1958,6 +1969,36 @@ virtio:
>>  #define CCW_CMD_READ_STATUS 0x72
>>  \end{lstlisting}
>>  
>> +\subsubsection{Notifications}\label{sec:Virtio Transport Options / Virtio
>> +over channel I/O / Basic Concepts/ Notifications}
>> +
>> +Available buffer notifications are realized as a hypercall. No additional
>> +setup by the driver is needed. The operation of available buffer
>> +notifications is described in section \ref{sec:Virtio Transport Options /
>> +Virtio over channel I/O / Device Operation / Guest->Host Notification}.
>> +
>> +Used buffer notifications are realized either as so called classic or as
>> +adapter interrupts depending on a transport level negotiation. The
> 
> "as so-called classic or adapter I/O interrupts"?

Valid. These are indeed called 'adapter I/O interrupts' through out
this spec. I was i a hurry to write up something demonstrating he idea,
so I did not check this. I think these are usually called 'adapter interrupts'
(without the I/O in between) elsewhere, but internal integrity is more
important.

I will take it.

> 
> (I'd really like a reference to I/O interrupts here... especially as
> the old, never standardized s390 transport used external interrupts.)
> 

You mean with the wording you proposed, or something more? If something
more could you do a patch on top (later)?

>> +initialization is described in sections \ref{sec:Virtio Transport Options
>> +/ Virtio over channel I/O / Device Initialization / Setting Up Indicators
>> +/ Setting Up Classic Queue Indicators} and \ref{sec:Virtio Transport
>> +Options / Virtio over channel I/O / Device Initialization / Setting Up
>> +Indicators / Setting Up Two-Stage Queue Indicators} respectively.  The
>> +operation of each flavor is described in sections \ref{sec:Virtio
>> +Transport Options / Virtio over channel I/O / Device Operation /
>> +Host->Guest Notification / Notification via Classic I/O Interrupts} and
>> +\ref{sec:Virtio Transport Options / Virtio over channel I/O / Device
>> +Operation / Host->Guest Notification / Notification via Adapter I/O
>> +Interrupts} respectively. 
>> +
>> +Configuration change notifications are done using so called classic
>> +interrupts. The initialization is described in section \ref{sec:Virtio
> 
> "so-called classic I/O interrupts"
> 

Same here. Will do.

>> +Transport Options / Virtio over channel I/O / Device Initialization /
>> +Setting Up Indicators / Setting Up Configuration Change Indicators} and
>> +the operation in section \ref{sec:Virtio Transport Options / Virtio over
>> +channel I/O / Device Operation / Host->Guest Notification / Notification
>> +via Classic I/O Interrupts}.
>> +
>>  \devicenormative{\subsubsection}{Basic Concepts}{Virtio Transport Options / Virtio over channel I/O / Basic Concepts}
>>  
>>  The virtio-ccw device acts like a normal channel device, as specified
> 
> In general, I like this.
> 

Thanks. I intend to wait for Michael's word before jumping a the other
transports to get the series non-rfc ready. Up till now reviews seem
favorable: I guess it's likely to happen.

Thanks for your valuable input!

Regards,
Halil


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

