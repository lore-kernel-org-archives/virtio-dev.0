Return-Path: <virtio-comment-return-2920-cohuck=redhat.com@lists.oasis-open.org>
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
From: Cornelia Huck <cohuck@redhat.com>
In-Reply-To: <YfET8pNaYoWZ6eFt@myrica>
References: <20220114225032.290762-1-mst@redhat.com>
 <20220119132319.5ee3821d.pasic@linux.ibm.com>
 <20220119112059-mutt-send-email-mst@kernel.org>
 <87k0eud0bi.fsf@redhat.com> <20220121033806.70b55223.pasic@linux.ibm.com>
 <87r191krbg.fsf@redhat.com> <20220124174052.1b6b423e.pasic@linux.ibm.com>
 <20220124132837-mutt-send-email-mst@kernel.org> <YfET8pNaYoWZ6eFt@myrica>
Date: Thu, 07 Apr 2022 16:28:03 +0200
Message-ID: <87lewharyk.fsf@redhat.com>
MIME-Version: 1.0
Subject: Re: [virtio-comment] Re: [virtio] [PATCH] virtio: clarify feature
 negotiation
Content-Type: text/plain
To: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, virtio-comment@lists.oasis-open.org, virtio-dev@lists.oasis-open.org, virtio@lists.oasis-open.org, Viresh Kumar <viresh.kumar@linaro.org>
List-ID: <virtio-dev.lists.oasis-open.org>

[sorry about resurrecting an undead thread; I'm trying to collect some
editorial changes]

On Wed, Jan 26 2022, Jean-Philippe Brucker <jean-philippe@linaro.org> wrote:

> On Mon, Jan 24, 2022 at 04:42:35PM -0500, Michael S. Tsirkin wrote:
>> So from that point of view, we are actually relaxing the requirements,
>> and yes we'll need to carefully go over each instance of
>> "offered".
>> I thought I did, but now I did a quick grep again and I found instances
>> in virtio-iommu.tex and virtio-gpio.tex
>> Both of these are new, so I think we can just fix them to "negotiated".
>> 
>> Jean-Philippe, Viresh, what do you think? Would it be a problem to
>> replace offered with negotiated, and restrict iommu and gpio drivers to
>> access config space after FEATURES_OK?
>
> No problem for iommu. The config space fields domain_range and input_range
> are not useful to the driver before DRIVER_OK. Reading field bypass
> earlier could be useful for debugging, but in that case going a few more
> steps into device initialization wouldn't hurt.

For domain_range and input_range, offered->negotiated looks like the
right thing to do. However, I'm a bit unsure about bypass. We currently
have:

"
An endpoint is in bypass mode if:
\begin{itemize}
  \item the VIRTIO_IOMMU_F_BYPASS_CONFIG feature is offered and:
    \begin{itemize}
      \item config field \field{bypass} is 1 and the endpoint is
        not attached to a domain. This applies even if the driver
        does not accept the VIRTIO_IOMMU_F_BYPASS_CONFIG feature
        and the device initializes field \field{bypass} to 1.

        or
      \item the endpoint is attached to a domain with
        VIRTIO_IOMMU_ATTACH_F_BYPASS.
    \end{itemize}
"

The "This applies even if..." clause refers to "offered, but not
accepted". I assume we want to do offered->negotiated even here, but
wanted to double-check.


This publicly archived list offers a means to provide input to the
OASIS Virtual I/O Device (VIRTIO) TC.

In order to verify user consent to the Feedback License terms and
to minimize spam in the list archive, subscription is required
before posting.

Subscribe: virtio-comment-subscribe@lists.oasis-open.org
Unsubscribe: virtio-comment-unsubscribe@lists.oasis-open.org
List help: virtio-comment-help@lists.oasis-open.org
List archive: https://lists.oasis-open.org/archives/virtio-comment/
Feedback License: https://www.oasis-open.org/who/ipr/feedback_license.pdf
List Guidelines: https://www.oasis-open.org/policies-guidelines/mailing-lists
Committee: https://www.oasis-open.org/committees/virtio/
Join OASIS: https://www.oasis-open.org/join/

