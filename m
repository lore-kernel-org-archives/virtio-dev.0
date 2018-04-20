Return-Path: virtio-return-3085-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio@lists.oasis-open.org>
List-Post: <mailto:virtio@lists.oasis-open.org>
List-Help: <mailto:virtio-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-subscribe@lists.oasis-open.org>
References: <1523300322-21989-1-git-send-email-pasic@linux.vnet.ibm.com>
 <1523300322-21989-5-git-send-email-pasic@linux.vnet.ibm.com>
 <79445753-5c65-3ffb-f84d-578a50037561@redhat.com>
 <e5e2df6e-59cf-9a97-861c-53b0e5160a79@linux.vnet.ibm.com>
 <2b0c61bd-d2f9-3bdb-32de-789e65a5a703@redhat.com>
 <29af1c28-c7b0-a461-3c53-9b029512c6d7@linux.vnet.ibm.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04b06c78-55de-5738-1940-4c558c0f75c2@redhat.com>
Date: Fri, 20 Apr 2018 17:45:26 +0200
MIME-Version: 1.0
In-Reply-To: <29af1c28-c7b0-a461-3c53-9b029512c6d7@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [virtio] [PATCH 4/5] packed-ring: reposition drivernormative on
 driver notifications
To: Halil Pasic <pasic@linux.vnet.ibm.com>, virtio@lists.oasis-open.org, virtio-dev@lists.oasis-open.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <virtio-dev.lists.oasis-open.org>

On 10/04/2018 16:59, Halil Pasic wrote:
>> I agree with that - but IMO you're now separating two related paragraphs.
>
> I'm not separating them they were separated, but I get your point.

Yeah, I meant separating them with a heading.

>> The driver MUST ensure the write to the \field{flags} field is performed
>> before the read of the Driver Event Suppression, in order to avoid
>> missing a notification from the device.
>
> Will do a it, but I prefer to make this an extra patch.

Sure, yhat's your choice.

>>> About the normative statements. I hinted before that I don't really
>>> understand the role of normative statements in this specification. To
>>> be more precise, my naive understanding of their role is in conflict
>>> with the reality of the specification.
>>>
>>> Can someone tell me what is supposed to go in a normative statements
>>> and what is supposed to go outside? Along with an estimate how good
>>> are we at adhering to those rules.
>> Anything that is declared "MUST", "SHOULD" or "MAY" constitutes a
>> normative statement.
>
> The problem here is, that this sentence you reformulated as a
> 'MUST' sentence was formulated as a 'has to be careful' sentence.

That was a mistake, in my opinion.

> My concern (regarding the whole spec) is the completeness and self
> the containment of it's normative portion -- I'm not sure if either is
> pursued rigorously. For instance take 'Supplying Buffers to The
> Device' either for split or for packed. The algorithms described
> there aren't constituting a normative section. Do you think these
> can be inferred from the normative sections?

Probably more from chapters such as "Basic Facilities of a Virtio
Device"; that is, it's the only way to use them so it need not be
normative.  Those chapters in turn could use some update with respect to
memory barriers, and sometimes lack some normative text.

For example "The Virtqueue Available Ring" for split virtqueues has
almost no normative text, and for "The Virtqueue Used Ring" (split
virtqueues too) "The device MUST set len prior to updating the used idx"
should mention a memory barrier.

> Are the normative statements (e.g in v1.0 cs4) sufficient to
> guarantee conforming implementations work (interoperably)? 
> 
> In math we have primitive notions, definitions, axioms, theorems, proofs
> and hypotheses. Textbooks also have less formal text (beyond the
> stuff listed) to either help with the understanding, or provide background.
> 
> My naive understanding of the purpose of non-normative sections of this
> specification is: definitions, background (e.g. legacy interface),
> and explanations facilitating *easier* understanding.

Yes.

> To stay at the math analogy, the device normative statements are
> most akin to axioms I guess. As axioms along with primitive notions
> and definitions, what constitutes a formal system.

Certainly not "fundamental" axioms (those would be things like a formal
memory model), but I understand what you mean and I think it makes sense.

Paolo

> So that's where my question is coming from. And I'm not keen to
> put too much work into this. I'm just curious how should I reason
> about stuff (when reviewing and voting for example). Sorry for getting
> philosophical.


---------------------------------------------------------------------
To unsubscribe from this mail list, you must leave the OASIS TC that 
generates this mail.  Follow this link to all your TCs in OASIS at:
https://www.oasis-open.org/apps/org/workgroup/portal/my_workgroups.php 

