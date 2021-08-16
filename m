Return-Path: <quic_svaddagi@quicinc.com>
Date: Mon, 16 Aug 2021 10:27:18 +0530
From: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
Subject: Re: [PATCH v2] virtio-mmio: Specify wait needed in driver during
 reset
Message-ID: <20210816045718.GB5604@quicinc.com>
Reply-To: Srivatsa Vaddagiri <quic_svaddagi@quicinc.com>
References: <20210813145351.GA5604@quicinc.com>
 <CACGkMEuuS+u8M9ufN1g87ng1U5CT3gWEW899=o0NF0jWOA5aUg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuuS+u8M9ufN1g87ng1U5CT3gWEW899=o0NF0jWOA5aUg@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Virtio-Dev <virtio-dev@lists.oasis-open.org>, Trilok Soni <tsoni@quicinc.com>, Pratik Patel <pratikp@quicinc.com>
List-ID: <virtio-dev.lists.oasis-open.org>

* Jason Wang <jasowang@redhat.com> [2021-08-16 10:10:56]:

> > +After writing 0 to \field{Status}, which triggers a reset of device, the driver MUST wait for a read of
> > +\field{Status} to return 0 before proceeding with the remaining steps of initializing the device.
> > +
> 
> Do we need to limit this behaviour to 0x3 only?

I felt it will be simple for drivers to unconditionally poll for reset
completion (which is the right thing to do IMO), but can make it conditional to
version 3 only if you say so.

- vatsa

---

Qualcomm Innovation Center, Inc. is submitting the attached "feedback" as a
non-member to the virtio-dev mailing list for consideration and inclusion.


