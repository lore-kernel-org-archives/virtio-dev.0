Return-Path: virtio-comment-return-1720-cohuck=redhat.com@lists.oasis-open.org
Sender: <virtio-comment@lists.oasis-open.org>
List-Post: <mailto:virtio-comment@lists.oasis-open.org>
List-Help: <mailto:virtio-comment-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-comment-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-comment-subscribe@lists.oasis-open.org>
References: <20210212095920.249768-1-peter.hilber@opensynergy.com>
 <20210215132029.GD12691@e120937-lin>
From: Peter Hilber <peter.hilber@opensynergy.com>
Message-ID: <e18cf222-ea57-5d0b-9ea3-47ebed868a10@opensynergy.com>
Date: Tue, 16 Feb 2021 16:11:42 +0100
MIME-Version: 1.0
In-Reply-To: <20210215132029.GD12691@e120937-lin>
Subject: [virtio-comment] Re: [PATCH v6] Add virtio SCMI device specification
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: virtio-comment@lists.oasis-open.org, linux-arm-kernel@lists.infradead.org, Souvik.Chakravarty@arm.com, Sudeep.Holla@arm.com, virtio-dev@lists.oasis-open.org, alex.bennee@linaro.org, jean-philippe@linaro.org
List-ID: <virtio-dev.lists.oasis-open.org>

On 15.02.21 14:20, Cristian Marussi wrote:
> Hi Peter,
> 
> just one remark down below.
> 

Hi Cristian,

thanks for your comments. Please see my reply inline below.

[snip]

> 
> [snip]
> 
>> +The cmdq is used by the driver to send commands to the device. The
>> +device replies with responses (not delayed responses) over the cmdq.
>> +
>> +The eventq is used by the device to send notifications and delayed
>> +responses. The eventq only exists if VIRTIO_SCMI_F_P2A_CHANNELS was
>> +negotiated.
>> +
>> +\subsection{Feature bits}\label{sec:Device Types / SCMI Device / Feature bits}
>> +
>> +\begin{description}
>> +\item[VIRTIO_SCMI_F_P2A_CHANNELS (0)] Device implements some SCMI
>> +notifications, or delayed responses.
>> +\item[VIRTIO_SCMI_F_SHARED_MEMORY (1)] Device implements any SCMI
>> +statistics shared memory region.
>> +\end{description}
>> +
>> +VIRTIO_SCMI_F_P2A_CHANNELS is used to determine the existence of the
>> +eventq. The eventq is required for SCMI notifications and delayed
>> +responses.
>> +
>> +VIRTIO_SCMI_F_SHARED_MEMORY is used to determine whether the device
>> +provides any SCMI statistics shared memory region. SCMI statistics
>> +shared memory regions are defined by some SCMI protocols.
>> +
>> +The SCMI protocols provide the PROTOCOL_MESSAGE_ATTRIBUTES commands to
>> +inquire about the particular SCMI notifications and delayed responses
>> +implemented by the device. The SCMI protocols provide additional
>> +commands to detect other features implemented by the device.
>> +
>> +\devicenormative{\subsubsection}{Feature bits}{Device Types / SCMI Device / Feature bits}
>> +
>> +The device MUST offer VIRTIO_SCMI_F_P2A_CHANNELS if the device can
>> +implement at least one SCMI notification, or delayed response.
>> +
>> +The device MUST offer VIRTIO_SCMI_F_SHARED_MEMORY if the device can
>> +implement at least one SCMI statistics shared memory region.
>> +
>> +\subsection{Device configuration layout}\label{sec:Device Types / SCMI Device / Device configuration layout}
>> +
>> +There is no configuration data for the device.
>> +
> 
> I could be missing something here, so I apologize upfront if this has
> already been discussed elsewhere, but AFAIU the fact that no device
> configuration is exposed here (like a device ID) implies that SCMI devices
> are not "identifiable" from within the VirtIO subsystem, so not
> distinguishable in other words.
> 
> At the same time in the companion RFC driver series it has been already
> also ruled out (as of now at least) by the DT maintainer the possibility
> to establish a link at the DT level between an SCMI virtio-mmio device
> definition and the SCMI related DT descriptions (because, AFAIU, it's not
> something needed by any of all the other existent VirtIO devices that are
> indeed usually somehow 'identifiable')
> 
> These 2 things combined together rule out any future possibility to have
> multiple SCMI devices defined on a system (at least not identifiable/usable)
> in order to support multiple distinct transport channels against the same
> platform (or, less desirable, multiple platforms), and in fact the SCMI virtio
> transport RFC driver as of now states upfront that only one device/once channel
> configuration is supported.
> 
> Even if not the norm probably, I would say that could be useful to leave
> open for the future the possibility to redirect some protocols down through
> a specific distinct VirtIO channel (other than the main one), at least for
> debug/testing purposes if not to support multiple platform residing in
> distinct VMs.
> Another use case could be separating the transport channel used by some
> possibly chatty protocol like Sensors (possibly flooding the system with
> lots of notifications) from other SCMI protocols, that could benefit from
> having a dedicated quieter virtio-mmio SCMI device channel (with dedicated
> IRQs and friends...)
> 
> Beside that, also the general fact that this SCMI transport does not support
> multiple channels is a bit at odd with all the other SCMI transports
> (like mailbox/svc that, it's to be said, are indeed based instead on
> shared memory)
> 
> So, what I'm saying here is if it's not the case of having some sort of
> device_id in the configuration space, so that a platform could expose,
> if it wants, multiple identifiable devices and the agents could pick the
> device they want and associate with a specific protocol.
> (via some DT transport reference to the desired SCMI device_id to use,
>  similarly to what's possible with shared mems transports)
> 
> But, as said, it could have been already discussed and ruled out so feel
> free to ignore this and point me at the related pre-existing discussion
> threads.
> 

This has not been discussed on the mailing list so far. I think both
features, multiple devices and dedicated transport channels/virtqueues
(similar to the SCMI SHM transport), do make sense, but we at
OpenSynergy do so far not have a use case which requires them. The
multiple devices feature would be straightforward to add in my
understanding (just add an `id' device configuration field). From what
you wrote I understand the dedicated transport channels could just mimic
the SCMI SHM channels scheme from the Linux kernel, with optional
per-protocol channels.

Virtio is extensible through feature bits in a backwards-compatible way,
so I think both features could also be introduced as extensions once
there is a need for them. (This is actually done very often for other
virtio devices.) I guess it would even be very straightforward to
backport these features to older Linux kernels then. Would this option
of introducing feature bits in the future address your concerns?

Best regards,

Peter


> Thanks
> 
> Cristian
> 
>


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

