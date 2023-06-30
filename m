Return-Path: <virtio-dev-return-13197-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C762EB64D7
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 17:12:34 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A656E2AED6
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 17:12:33 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 6BDFB9866F0
	for <virtio-dev@archiver.kernel.org>; Fri, 30 Jun 2023 17:12:33 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 4FC219866ED; Fri, 30 Jun 2023 17:12:33 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 3B3FB9866EE
	for <virtio-dev@lists.oasis-open.org>; Fri, 30 Jun 2023 17:12:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
X-TM-MAIL-RECEIVED-TIME: 1688145148.926000
X-TM-MAIL-UUID: ecc4e6de-1b24-41d7-9602-6e0885476716
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LcicaTdYXgJ2Q9pcX8iu5zv+a2OKAQaqWkHAypkYVUv7sq9/T6IgB9S94TIzF6Abhf5XN3X+/mO+o/75Dl/8GSymlsFtg7Ov3nwL7v3A7STFe/xwkWeDAkXRxZkkjUEaxRowxvOf88Ieq94rncbnEXjpcsNhB5QGefszybw1mokTxRUhhA/wwmS0XbG05VuuYB7WGWhqSmMZjSwuJzFiKVWI4x/2GzPlhJI9N9pZSAWxruIUxGaf5EAZroxncpRMzoBK1QMjXPt1EXoVglY8vGZejsLIrbntyJSe24jhIdTNvrKjEaqXbjPTxJ9zrr8VILCmpcPGOQb1bgaTj9EHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdO2lE+LOBQ7ZjewmLPpUugGZYDZX1sH1iViVOdfHXY=;
 b=UfeidBGrk25sl6arl7pnTs8d8571EpXJXGiV1pv/EjcF0K6Un7/3UCJ+ycbC/JbKfGCVy9aTLCFdSjlVXfToNEGAXKXjHeippkmGB/qAIHSQiYyJWdCVGMpOLC+V/wXZDKW8Zlpc2epLpjAkFmhz5kRW6tKNI91YvNn1AUgvhfdKzQuS2xeqIuHW5qbJMPt8s6UnNnRWN/plw5qgWv6W1PgBo96BFhWQmZWRydH+hm4p4F6IDh+kSOzKC5zfFobLgEfaHvWVKaNeK6jUNFTrXVDR8EjDd3rCtsXAHnwmbDTjQutwi8PopnQ95B+4YNzcUMB7F8rfDJHxX1/06Vy90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 217.66.60.4) smtp.rcpttodomain=arm.com smtp.mailfrom=opensynergy.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=opensynergy.com; dkim=none (message not signed); arc=none
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 217.66.60.4)
 smtp.mailfrom=opensynergy.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=opensynergy.com;
Received-SPF: Pass (protection.outlook.com: domain of opensynergy.com
 designates 217.66.60.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=217.66.60.4; helo=SR-MAIL-03.open-synergy.com; pr=C
From: Peter Hilber <peter.hilber@opensynergy.com>
To: virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Peter Hilber <peter.hilber@opensynergy.com>,
	"Christopher S. Hall" <christopher.s.hall@intel.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Jason Wang <jasowang@redhat.com>,
	John Stultz <jstultz@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	netdev@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Date: Fri, 30 Jun 2023 19:10:43 +0200
Message-Id: <20230630171052.985577-1-peter.hilber@opensynergy.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6EUR05FT048:EE_|BEZP281MB2773:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4c79124b-aad8-415c-7527-08db798d2de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PgYi7Fjn10lvcHHaVkT3xtyqb3hUjIRRpj27QrOPX+QDSBQ9dS15ey2gtQfI3pUDtavqN9EB0lNz6PqRG2IsHBywhzeoBm823QDBCKjOSuMoaybPq4Q6yRDi3rA2++eR64BAkEQa/DyluqOqTe2KJ4kpSlqoaNR49O8bruLXCeIH0a3j7g5II5bNE86SjaP+4KyatDWoj8FpqspcOgd6m3jVIHRs/fivdZC0V5yihxIXfkg4WyBDGKZix1DBVlqDzb0Df0H+sSC0nLRl0uW0J5tZmGyrZM4euhAhx4DHXxRs0ryzUr6Fk1GpTO2z4wRqNe9STXCjXKaTj4wWkd39f9qvyCrxqcz6ERWRwIOjkI/5IlO1WN+dLxvwS9Ou8cGDIRumUdPrKoKRMz6GjjU3R3BZnNcquPZ/9zoQ9N1z6b2qG6mfuU7xsCUVbSN19PYrYDddFVQSsSOzZLZzLDn84OZz7Lhg9xg6lIqPE6V2SJj1i6GRFMJD0CozmoK1SJGURX9nsxrOqub9QmaLt9kpi65eRZh7I1Y+U+1gUgrORjRMRovXB3FzMBfaDdp5Uedi7apR1kd0jFxnpi63Gc24IJPo7dRFqdnSDNAtRbzmxYj23tyVW4h7HSyPJK05x+0lRUd2fHWYoNwyiY16gsg/fj+O6qnEdaX3E+5VBVmmDeWNdIgYihmTVUgBezYBZaJ35WBafLeAX8uUZ8Z04Pf03cXEXbj6SlymPJtawsEvFWpGyOsuA23PIOFxjsg1FILkVSnieC8DjWsJzEGQPhcQIyvbgh6eT5CCNYqz3/PWlIKPZdsBYGJurgK2iEduiJRH
X-Forefront-Antispam-Report:
	CIP:217.66.60.4;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SR-MAIL-03.open-synergy.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(396003)(39840400004)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(41300700001)(82310400005)(186003)(2616005)(83380400001)(81166007)(336012)(1076003)(47076005)(26005)(36860700001)(966005)(40480700001)(54906003)(86362001)(478600001)(316002)(2906002)(42186006)(36756003)(70586007)(70206006)(4326008)(5660300002)(7416002)(44832011)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2023 17:12:26.9310
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c79124b-aad8-415c-7527-08db798d2de0
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=800fae25-9b1b-4edc-993d-c939c4e84a64;Ip=[217.66.60.4];Helo=[SR-MAIL-03.open-synergy.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM6EUR05FT048.eop-eur05.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BEZP281MB2773
X-TM-AS-ERS: 104.47.7.176-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1011-27724.001
X-TMASE-Result: 10--21.904400-4.000000
X-TMASE-MatchedRID: QkBk6NM3bYntZDpZlNWg4O3qPLdU3cUZmmVIK8ewxWFzGLNi78J47a1E
	3eK47PQv8NnPKwQ6MAXIfQ4ROYO30qR3czjQoJVEzHEBgfJ+fh7XT+yjPvIHsSPyEm8irOu0hto
	XpFBNnP0hNGbe+yEJt2s6L9BEkSPmik3s3JIv+NL24vmE69obUuZaGzHq+v3RvISQdexW7wlJus
	yl/yyXJshX3ePBhmH9FAYnhafAyPf3/e1f1P1EBXzRkrQz4xEZXEX7ABoMsg2XYoGYte3R6uKgz
	T/C1UJV14kqJij0HUVjAv+2f9eNNtEGCeLQeM4pOPwPJT+A+aKJa69fq6pvWqFqih+YTZsXbbVF
	KI0Q90Cf1UKFSLOBJveAK/DlpM8DO8W+8t9FmIHHfwwbjh/dN0CkBGbPTuJGvnGHhmr9238mm1Q
	XaIrWncO1oHRChDtjynqv1hVDlo9PfXLU39GOm+sfkPrj7CaqXpSxZKDDzFgLDzQJD3kt0DFA5d
	FB9NsjmPP9edzaP5qx6frpJFf/MOEt1Iuwj4gXsZIjJc0QK/Yyep+wopoUNa3/rEOakn8sT0BRZ
	NI+YwbANog326X8vgFaXg5vJyaC8J0BxWW1D95qBJKosT8FWDnxJqun3snzJQhrLH5KSJ0=
X-TMASE-XGENCLOUD: 2a743da6-ac22-4058-955b-c93c50018bcc-0-0-200-0
X-TM-Deliver-Signature: 3643810533B55FE489482FDFA1BD4FCE
X-TM-Addin-Auth: Q7PgLWEeSdzvCNfWq2rJPuhGUJCD88VJzCDy377dGoz1njPjMAh3WgItGne
	E2wE2oTIs+WW/VFGKtU5qo0uaSIMvaNWsusYYsg7xZ16AWgGe7uknGkVdNqPbN0TkCaRAMinZLd
	uQyd1n5dR965J55dEUDnXJuLof2efX6L1QU6BtB3WYkC2SrmyeK9h1cVe7gl1BApvd9ZunZNpyh
	P5Ka9NQPiuBPMI8Ina/T7O62VxTKrFRzhjMo9j5l+0mShbgFhEyHw4hwxgoR3F1dVWTpEvBJH90
	hXq66OY1Qh33e5g=.Jt4xSX+jWK2BJvivHcC4QNTr169gz/W6he7aZGC2L96bcpqS6RY1NZSqBK
	niEQGL/5j6GsfdRhQZwLOcQwzYzxw00SVjvg35OPvszWlGedUFEafCsxwpdJq2gyKmE4PR1ilRX
	+1pa7R2UgWurVtBwTA0bi3zeCUhrPuWrI7Jld/L1UJQe6JxXi//6OAjxA/XApIN55duhcv3KXAP
	x9oOZxkfe/OwQp+DtOljscCvKlyiW4TuYqA1nt2iHRTPn5KVz2pyKDCBRnPmRGC1T6PQP1wfRmU
	H0CDlhPVHQ9z47T7kVDGsk965W8D5KMicZNnEFqTQL67e7QNsBowgUNMUNA==
X-TM-Addin-ProductCode: EMS
Subject: [virtio-dev] [RFC PATCH 0/7] Add virtio_rtc module and related changes

This patch series adds the virtio_rtc module, and related bugfixes and
small interface extensions. The virtio_rtc module implements a driver
compatible with the proposed Virtio RTC device specification [1]. The
Virtio RTC (Real Time Clock) device provides information about current
time. The device can provide different clocks, e.g. for the UTC or TAI time
standards, or for physical time elapsed since some past epoch. The driver
can read the clocks with simple or more accurate methods.

This patch series depends, through its arm_arch_timer patch, on patch
"arm64/arch_timer: Provide noinstr sched_clock_read() functions" [3] which
seems not to be available with all development branches yet. Pull [2] for
an equivalent series on top of mst/linux-next, which should apply without
the above patch. Pull [5] for an equivalent series on top of
tip/timers/core. Pull [6] for an equivalent series on top of
tip/sched/core.

The series first fixes some bugs in the get_device_system_crosststamp()
interpolation code, which is required for reliable virtio_rtc operation.
Next, expose some Arm Generic Timer clocksource details for virtio_rtc.
Last, add the virtio_rtc implementation.

For the Virtio RTC device, there is currently a proprietary implementation,
which has been used for provisional testing.

virtio_rtc exposes clocks as PTP clocks to userspace, similar to ptp_kvm.
If both the Virtio RTC device and this driver have special support for the
current clocksource, time synchronization programs can use
cross-timestamping using ioctl PTP_SYS_OFFSET_PRECISE2 aka
PTP_SYS_OFFSET_PRECISE. Similar to ptp_kvm, system time synchronization
with single-digit ns precision is possible with a quiescent reference clock
(from the Virtio RTC device). This works even when the Virtio device
response is slow compared to ptp_kvm hypercalls.

The following illustrates a test using PTP_SYS_OFFSET_PRECISE, with
interspersed strace log and chrony [4] refclocks log, on arm64. In the
example, chrony tracks a virtio_rtc PTP clock ("PHCV", /dev/ptp0). The raw
offset between the virtio_rtc clock and CLOCK_REALTIME is 0 to 1 ns. At the
device side, the Virtio RTC device artificially delays both the clock read
request, and the response, by 50 ms. Cross-timestamp interpolation still
works with this delay. chrony also monitors a ptp_kvm clock ("PHCK",
/dev/ptp3) for comparison, which yields a similar offset.

	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000329>
	===============================================================================
	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
	===============================================================================
	2023-06-29 18:49:55.595742 PHCK    0 N 0  1.000000e-09  8.717931e-10  5.500e-08
	2023-06-29 18:49:55.595742 PHCK    - N -       -        8.717931e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101545>
	2023-06-29 18:49:56.147766 PHCV    0 N 0  1.000000e-09  8.801870e-10  5.500e-08
	2023-06-29 18:49:56.147766 PHCV    - N -       -        8.801870e-10  5.500e-08
	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000195>
	2023-06-29 18:49:56.202446 PHCK    0 N 0  1.000000e-09  7.364180e-10  5.500e-08
	2023-06-29 18:49:56.202446 PHCK    - N -       -        7.364180e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101484>
	2023-06-29 18:49:56.754641 PHCV    0 N 0  0.000000e+00 -2.617368e-10  5.500e-08
	2023-06-29 18:49:56.754641 PHCV    - N -       -       -2.617368e-10  5.500e-08
	ioctl(5</dev/ptp3>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.000270>
	2023-06-29 18:49:56.809282 PHCK    0 N 0  1.000000e-09  7.779321e-10  5.500e-08
	2023-06-29 18:49:56.809282 PHCK    - N -       -        7.779321e-10  5.500e-08
	ioctl(6</dev/ptp0>, PTP_SYS_OFFSET_PRECISE, 0xffffe86691c8) = 0 <0.101510>
	2023-06-29 18:49:57.361376 PHCV    0 N 0  0.000000e+00 -2.198794e-10  5.500e-08
	2023-06-29 18:49:57.361376 PHCV    - N -       -       -2.198794e-10  5.500e-08

This patch series only adds special support for the Arm Generic Timer
clocksource. At the driver side, it should be easy to support more
clocksources.

Without special support for the current clocksource, time synchronization
programs can still use ioctl PTP_SYS_OFFSET_EXTENDED2 aka
PTP_SYS_OFFSET_EXTENDED. In this case, precision will generally be worse
and will depend on the Virtio device response characteristics.

The following illustrates a test using PTP_SYS_OFFSET_EXTENDED, with
interspersed strace log and chrony refclocks log, on x86-64 (with `ts'
values omitted):

	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	===============================================================================
	   Date (UTC) Time         Refid  DP L P  Raw offset   Cooked offset      Disp.
	===============================================================================
	2023-06-28 14:11:26.697782 PHCV    0 N 0  3.318200e-05  3.450891e-05  4.611e-06
	2023-06-28 14:11:26.697782 PHCV    - N -       -        3.450891e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:27.208763 PHCV    0 N 0 -3.792800e-05 -4.023965e-05  4.611e-06
	2023-06-28 14:11:27.208763 PHCV    - N -       -       -4.023965e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:27.722818 PHCV    0 N 0 -3.328600e-05 -3.134404e-05  4.611e-06
	2023-06-28 14:11:27.722818 PHCV    - N -       -       -3.134404e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:28.233572 PHCV    0 N 0 -4.966900e-05 -4.584331e-05  4.611e-06
	2023-06-28 14:11:28.233572 PHCV    - N -       -       -4.584331e-05  4.611e-06
	ioctl(5, PTP_SYS_OFFSET_EXTENDED, {n_samples=10, ts=OMITTED}) = 0
	2023-06-28 14:11:28.742737 PHCV    0 N 0  4.902700e-05  5.361388e-05  4.611e-06
	2023-06-28 14:11:28.742737 PHCV    - N -       -        5.361388e-05  4.611e-06

The following udev rule can be used to get a symlink /dev/ptp_virtio to the
UTC clock:

	SUBSYSTEM=="ptp", ATTR{clock_name}=="Virtio PTP UTC", SYMLINK += "ptp_virtio"

The following chrony configuration directive can then be added in
/etc/chrony/chrony.conf to synchronize to the Virtio UTC clock:

	refclock PHC /dev/ptp_virtio refid PHCV poll -1 dpoll -1

This patch series adds virtio_rtc not in drivers/ptp, but as a generic
Virtio driver. In the near future, virtio_rtc should be extended with an
RTC Class driver, along with extensions to the Virtio RTC device draft spec
to support RTC alarms.

Feedback is greatly appreciated.

[1] https://lists.oasis-open.org/archives/virtio-comment/202306/msg00592.html
[2] https://github.com/OpenSynergy/linux virtio-rtc-v1-on-mst-vhost-linux-next
[3] https://lore.kernel.org/r/20230519102715.435618812@infradead.org
[4] https://chrony.tuxfamily.org/
[5] https://github.com/OpenSynergy/linux virtio-rtc-v1-on-tip-timers-core
[6] https://github.com/OpenSynergy/linux virtio-rtc-v1-on-tip-sched-core


Peter Hilber (7):
  timekeeping: Fix cross-timestamp interpolation on counter wrap
  timekeeping: Fix cross-timestamp interpolation corner case decision
  timekeeping: Fix cross-timestamp interpolation for non-x86
  clocksource: arm_arch_timer: Export counter type, clocksource
  virtio_rtc: Add module and driver core
  virtio_rtc: Add PTP clocks
  virtio_rtc: Add Arm Generic Timer cross-timestamping

 MAINTAINERS                          |   7 +
 drivers/clocksource/arm_arch_timer.c |  16 +
 drivers/virtio/Kconfig               |  43 ++
 drivers/virtio/Makefile              |   4 +
 drivers/virtio/virtio_rtc_arm.c      |  44 ++
 drivers/virtio/virtio_rtc_driver.c   | 841 +++++++++++++++++++++++++++
 drivers/virtio/virtio_rtc_internal.h |  85 +++
 drivers/virtio/virtio_rtc_ptp.c      | 384 ++++++++++++
 include/clocksource/arm_arch_timer.h |  19 +
 include/uapi/linux/virtio_rtc.h      | 159 +++++
 kernel/time/timekeeping.c            |  20 +-
 11 files changed, 1615 insertions(+), 7 deletions(-)
 create mode 100644 drivers/virtio/virtio_rtc_arm.c
 create mode 100644 drivers/virtio/virtio_rtc_driver.c
 create mode 100644 drivers/virtio/virtio_rtc_internal.h
 create mode 100644 drivers/virtio/virtio_rtc_ptp.c
 create mode 100644 include/uapi/linux/virtio_rtc.h


base-commit: 6352a698ca5bf26a9199202666b16cf741f579f6
-- 
2.39.2


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

