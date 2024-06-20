Received: from refb02.tmes.trendmicro.eu (refb02.tmes.trendmicro.eu [18.185.115.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB1417624F
	for <virtio-dev@lists.linux.dev>; Thu, 20 Jun 2024 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=18.185.115.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718885250; cv=fail; b=ZyOf53tV4T19OOZzprsiA3gZ/R0pBLCTFapfVn3Nb+Ol306IJu1RYMZakxHIvDVJiCNKSSM2auaTYuTT9OI5m1JCDjXh/HfNDfRx84CzxHdOC7Lmz9XQWofK89IQmzwgjAIMqog1B7v6r3kibv82mDirlddhx82f4j4s1uJ0Wa4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718885250; c=relaxed/simple;
	bh=O0GMQ9dOhVakRCX8D0CnxQRmxu0Ue/8ECkjt1UD/ANk=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=crdb8yzLMNTbMdPuScnjQp/XU0AExcTXc3mRX33WnH2LOX3Rj9/YYqMcb4gvPe4dzmyHH0gmJiEdsqyq0K6KiiIZH2rfpnK9pE0irrNimAV79w3+CEOQ0Ue2M4jWyKympXdPtlNtC51zboCkWSjmOQ0s0CXa6j4MW+REarQoKXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com; spf=pass smtp.mailfrom=opensynergy.com; dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b=vN1QuG8l; arc=fail smtp.client-ip=18.185.115.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensynergy.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opensynergy.com header.i=@opensynergy.com header.b="vN1QuG8l"
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.10.202])
	by refb02.tmes.trendmicro.eu (Postfix) with ESMTPS id 5A2FB10065C5F
	for <virtio-dev@lists.linux.dev>; Thu, 20 Jun 2024 12:06:44 +0000 (UTC)
Received: from 104.47.11.168_.trendmicro.com (unknown [172.21.191.80])
	by repost01.tmes.trendmicro.eu (Postfix) with SMTP id 6ECB510001FBC;
	Thu, 20 Jun 2024 12:06:37 +0000 (UTC)
X-TM-MAIL-RECEIVED-TIME: 1718885195.787000
X-TM-MAIL-UUID: d2e37d00-fef0-49b7-aec9-70d137e25fd1
Received: from DEU01-FR2-obe.outbound.protection.outlook.com (unknown [104.47.11.168])
	by repre01.tmes.trendmicro.eu (Trend Micro Email Security) with ESMTPS id C0672100058E4;
	Thu, 20 Jun 2024 12:06:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FY4oPwPstlIyOwGkpFqr5npjuq435VnyMAjrtwCiyZ6b8zF636t3Le94UtSab9RpUba4miz6sdyddCovmcgCAaGeChOgYBV9E75nMjNRxbpO8X+4BM5FgJSBYlIGO634hiydmmAnKCOiwvFvD7oPqGGcEcEUEu6XoxZ0OLzK8REEapARcvjd7aBgx74R7MZDv66Y199FiuYzSz9wmQCZgHzesFqLkhx7BTlUqaVP5r/svXQlzcKQlKE491KziZV1qdaNMHgMGuguHhAKFeCE1rQo2yY60BBx6KCMCRqQfzT0p/wZX63DxZuUSWp2o5Ujpm1PMPLKk8ZW421Nk/LDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VbN30poB3tCwfYn66GoIIo56ast/jE9yfXeLEQFi7ho=;
 b=hDdIRtjJdLSfr7sKo4jsW+9ZTwRuBxzT4xXPZ0F0+RvQod9zvk6X5N1VBiDXCkwRGOwnuTohUduHm6sKKi+n+qeeWgPT3mpttkSAFSdYPs86ApcdVTvHlt1dfPqo0ucvOYtuCNf4L1OIe4sJLUGPBm2TfvvVWbO79hUKYou9WAMc4zqRiNNDb0BCEKfI0R1lgIeeXFvXvfOvInV0bazyMp6EHbJ1PN6qCbQ1+7kvYsUYKr9dpnESW1vEcy3xvyQ3dhs0YVfoN2QKfOjw2WOQzbRHwzcVNaTcpbRMWsaRlDh6t6gse6A0CqkHMc/pqWfn5dx95Z6WtmtNFlSMv119EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=opensynergy.com;
Message-ID: <f0d5858e-66c5-4a74-b43b-625f1ba22314@opensynergy.com>
Date: Thu, 20 Jun 2024 14:06:32 +0200
From: Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [RFC PATCH v3 6/7] virtio_rtc: Add Arm Generic Timer
 cross-timestamping
To: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 virtio-dev@lists.linux.dev
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
References: <20231218073849.35294-1-peter.hilber@opensynergy.com>
 <20231218073849.35294-7-peter.hilber@opensynergy.com>
 <e410d65754ba6a11ad7f74b27dc28d9a25d8c82e.camel@infradead.org>
Content-Language: en-US
In-Reply-To: <e410d65754ba6a11ad7f74b27dc28d9a25d8c82e.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0337.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::14) To BE1P281MB1906.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:3d::8)
Precedence: bulk
X-Mailing-List: virtio-dev@lists.linux.dev
List-Id: <virtio-dev.lists.linux.dev>
List-Subscribe: <mailto:virtio-dev+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtio-dev+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BE1P281MB1906:EE_|FR2P281MB0105:EE_
X-MS-Office365-Filtering-Correlation-Id: e48352d9-79ec-4faf-2a8c-08dc91216ddc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|7416011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dGJwSkhjZHNmak9BSG1HdlUxcXI3ODZKYXBjUUE2em0zZTY1WFpacTg2aU8y?=
 =?utf-8?B?bkd4bVBEcGpWNGFyZUVoYVJwNlpSQ2xkeVhjZHdJNkRmdW1VWWVlaU5uOG9y?=
 =?utf-8?B?ZVpHKzNvWlBkTzRvZStWSGlLeGMrWTN2U2RNS3NEU2ZnQ1V6dWxLNEgxQ0ZG?=
 =?utf-8?B?dlBRWTZydjh5Mm4zRVZIM2c5ZDFyVmY1NzRleXI2amFCelN4QXA2NllFU2VL?=
 =?utf-8?B?ZUpxd3FzcjB2SnY0N1gxQ0NHUGdidGZjeWdvMGVpU3RTT0dlemFwS0JjZWV6?=
 =?utf-8?B?RmxzMm9BcFBTNW1GQURoSlZQNjl4c3BjQzhBSjJYRkVlK2s3UnVRTS9Zd0t4?=
 =?utf-8?B?Tm5RMzVxZ1BsaDdtVi95SVhkd2V6SENteGE1YWVkMFcyY2p6ajZaWkhuSTZI?=
 =?utf-8?B?U1dvWmlSQmxOQ3h1TFRXdmR6TzU1T2ZnYU91Znk2UVc3eUFCenVYZ2lvZXBh?=
 =?utf-8?B?UWg2YWZORlRHK2Fua0ZYSlRaZlZCRWR0SDQ1UG9hejU4eEErelZuYWZjQmFG?=
 =?utf-8?B?SllOdENFTG1zampaZSsrcUNWL2ozaS9BWTNTYm5TelJEUFpZNVo2OW14TGpW?=
 =?utf-8?B?WDdYRllkVEpRaG5wTFEzbXJyUnhFTmN5T1ZZZlpMUVFkeStBczI0d3VwRml0?=
 =?utf-8?B?OGovVkJsVzJEbzlPK2lzSXpBc1FwVDJwZVc1bmtmZ1VpSkhLN1ErZm9LZlVp?=
 =?utf-8?B?djB3T0hHdjRMN0Rwcmd0K1VnY1djZ1NSdHNvSStBSnRjWHVYRWRtdlQ0VGxw?=
 =?utf-8?B?V3RRd285dlAySXovVW11UVlyc2lzOHplMkNuaERqNW1UbG1SS0RkaCs1VHg4?=
 =?utf-8?B?ZXZQWGhkeHdnT2RHQ3lPMWMyYVZyeE40WW05OWJJSjlVREdsaG5kRlFaN3lS?=
 =?utf-8?B?bXdkaTFGdThEMDNyZ1pXeVhVcGNKVGJlN2hUaWJaT0Z2M0V6c2E5cjkyTDZ1?=
 =?utf-8?B?c3pJQ3JMc0Z1K2txenVrdlFVbGhNbHkxanlDbEFnckdGMVBWVzFEc2JnMWVD?=
 =?utf-8?B?NWNzTjkzc2ZYdUUxbENyVm1BaGZubys1UGNQczJYRkRUOWN1WEplalFIMGda?=
 =?utf-8?B?NlphVzEzTjhUZVAxRjhZMlA3ckRtYnlOYTdZcVd6YXZ0WXRFTXZzUUlmUkIz?=
 =?utf-8?B?R1BpMkdkMnBPVGRHQzlXVUlrc0cybDhHTVZjblQzRWtFQW52RXUwYW5ESFBM?=
 =?utf-8?B?c2lDcUM5MlkwMkNveGRwYUUzTHFyelQ0YlpNaEtoZVdyYXBpbmtJWEpLaWJo?=
 =?utf-8?B?KytzOGJaVlRsVVpZQU8wRlp0aEk4RFJINm1PZ1lXYUVqQW1wbkN3OGdoMFlr?=
 =?utf-8?B?YUFyZTAxSUV0cllpMktvdHRRRlR5SE4xSDd0dlFPaGN1bnpmTmRCaGxESTFH?=
 =?utf-8?B?YUZkbGFFUEpnRlUwRlphaEtoOWlZeVdwZ0REMzAwUTgwYVNNQUNxakdCWWNT?=
 =?utf-8?B?T1RxRDZSbUZZeXZsaFBHTmlrR1h4dkdoYjNsOG5oRGpCSXY3Tkoxa2tYbW9G?=
 =?utf-8?B?emJSdGxodUhBYlNMdjdKeS8wOHBwSWVyNFVMRkVxR1MvMENLNjRZYVBGYzl4?=
 =?utf-8?B?MTlrS1dHa2Q5UlNMcFhpY243aWZUb21WdjE3bUlPTTRKcnhRVldFVlBVaVM3?=
 =?utf-8?B?K1N4Vmx6RFdQbWhZdm92a2hGNFl6cVp6MndBbUlhdUFsOHVFYVhHNjlHWURY?=
 =?utf-8?B?WW80MUdSK3RQMFhsUkxLKy9wKzlEZUtwS255cnRJQ3Y0OVhhazJrUzBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1906.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(7416011)(1800799021);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXVDVE5jRVNoeVRGNy9nK1M1TGt3elVSK2paL1VmNk01MmtNM0Y5QjR2Z2M5?=
 =?utf-8?B?S3M3YTEyQ1laeW1ielNrWXNkZE9IR0k5YUhXdEhRSVk3WGFhNWh1SStUTGIx?=
 =?utf-8?B?V1BSeE5hRFFQNXRZdk1BVVFoWllqbDU2Z2Noa0F0bkJDbVNxM0dJUkFlRFVZ?=
 =?utf-8?B?dTh6S0ZTTTdIWXRCZUNTbk1kb1ZKaVdlVk1ZQ1JBZ2hlR3h1M0QwOUQ5MmdY?=
 =?utf-8?B?ZE1uK1dNSkhtdVJUcmovZEN6MW9xUDVaZXFjTXk3RUNrYnhhUWlxb200aG1S?=
 =?utf-8?B?ckdZaWtCR0p3blZIUWNqUTNmbnpWV1ZlTjNFZDVIUjBuV043Wkx2RjVCWDBI?=
 =?utf-8?B?Nm0wZUhxZ1FBK0ZHTHhia09nT0ZRcGpCK2dCUklReFFuZG9HdGxnaWJ3V3lv?=
 =?utf-8?B?aE5iRTdpbW11ZU1MZGt2QXNMTjU3R2lwZysyMGhYMFF3aFZ6cURZWS9HaTZW?=
 =?utf-8?B?L0IzeForWXhvSEpZdTVNc2Zkd1gvQmxJb1JnWGgybXY3cjNwQTl1akZacGFx?=
 =?utf-8?B?QlF3aXRHMjVzREJXblFDR0JYay9jN2pHcks1bllRNXFqRDR6Tm1md1A2bi9u?=
 =?utf-8?B?dTZkS0J5VFcyU2wvSW1PVzkzSHBTUXEvOHdSZHArUUF3K1JTaXk3ZWNCazhx?=
 =?utf-8?B?bnpQSUg5cmFnd29YTyt0Q2Vna3ZaR1FERHpGRmI5b2xubG9FWmlsV0RTV0I1?=
 =?utf-8?B?d2RYaW5ycGN6STlQd0k3NndzekUxRGdKSlVNSTZpTWZpemF0VWZnOHloWTNH?=
 =?utf-8?B?VjVqUTI0VzhuYzFDaXlHaHp5Vm9TYnlIMFAxbWhkNnpybkFJOVZJWGdQZ2tJ?=
 =?utf-8?B?OTZZWEZDWkRPN0phQ0xFS0FTRFg0L00wVnFXcnFnaDhkSUloS1orNU1yaGdv?=
 =?utf-8?B?aU41ZWNHOFhNRC9iUVNtQ2NWVzZuT1ZsM3FocHF5OXVSMnBRdVFic0JzOFNR?=
 =?utf-8?B?SVBYaHBWbkR1UVFoQWV3V09MRVNMbGo0YzVFTDllSDhmT29OVDVTTGd4NDFB?=
 =?utf-8?B?aUpCR3hIQndBRjVqNmdiUEI0WHBLL3hoTXlqcFlXWWJ1bEV0em9OdXBjTHZY?=
 =?utf-8?B?OVlBcVBNUTNQdnE2dG03SlpJeHE2MUsra2h0N1ljcDIrbmowbkFCbFh1Rmoy?=
 =?utf-8?B?Nzd1Nm4rWnpQOVkxcjdHR2hLbEsrNGdyMmNzU2Y4VkRZSDdHZDdoQnNtT1VZ?=
 =?utf-8?B?SUVCTG9NTUlzd3hNdFRsbUNKcmJvU2ZPZU0rUkQ0bVl6TlhNdC9FTTRsSlpC?=
 =?utf-8?B?dEF5NFlBNElMWVBkMmQxY3RXQ2sxcGhpR09UdkVBQUZvZmViR0kyVXo3bnFk?=
 =?utf-8?B?ZU1KQnNab3BHTUJmQ05BSEhld3B1WmlFb1pQK0tBTURTL0tjNlNGelFDMHgy?=
 =?utf-8?B?Z1JUbDVuek9MR3F0ek1lK1B4bzhoVW05NzhVbGM3VVZlbEpscitsYkFzd24y?=
 =?utf-8?B?c09JT0EwdkliV0F6QWlIYXF2aUY1WnJvQnp1ek9UclFpVXBJTjZ3anl6WTVN?=
 =?utf-8?B?VzY4Y1hnSUYrWFRVdmtNejZPZ3Z1TzNKY3R5YURzT21ua0lhUVBxQm1ta1Bt?=
 =?utf-8?B?U21oZVFHYzBPdjJadHBlT2RvaUZwT0E2eHBiNlVKNEVkUmZjN0FIVXB1d2Zl?=
 =?utf-8?B?UENZNkdKWkNubnNKdEVVOFJEV0NVOGg2VkNmSm8wTVpsRUVpWFR0RG9YY2xF?=
 =?utf-8?B?ZzBEVGZybUpVSDRGaHI0bTNFSFloRUlOUWtXKzN4amxjVFJIdlpzS0hPd2pH?=
 =?utf-8?B?NXNZMkx4eHBIaGlXMURFc3hZOG9lOUh4TnptZEtiNjlHeXpzMnQxdW94ZGZN?=
 =?utf-8?B?MUd5dFlET084SjBWUDhyaFhmSlBmbHpaTDJKUlZwVmJmbnpkWnEzWnVNWlVF?=
 =?utf-8?B?VHp1V1lHTkdUUXBjN3p0YVBnS1ZEM3EvUlNKOEZKYU8rWW1SR3FtbnZhRkdn?=
 =?utf-8?B?Z214MVNla1pCeVFqN0tTam1xVzU2STcwd1NvNmxqSzVQb01pT3ZUTWF0ME52?=
 =?utf-8?B?ZTRDRjVZMFNSVXk2ZFhGOHBQQ28yL3BuSUpYYWYvU2ZUdzlaUnJ1d2FyOTg0?=
 =?utf-8?B?YW9tSEVJNFRMYTZET3BiUXBpeUFuUVdYQkJyRWFTSGpqbnZKbXFGN014RWUr?=
 =?utf-8?B?N3F2V1FKYzNRdzZHVWZqYU1FWURZZ3dIamxlTHRGRnUwQS9reXdubEVRb05u?=
 =?utf-8?Q?sCT7r24a9u1wW4ewdizXDVR+szd9hW/umHbcY27JoYFk?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e48352d9-79ec-4faf-2a8c-08dc91216ddc
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1906.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2024 12:06:34.4817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EadJRaunBpgc4oiNMX7DKeJdBr65AHUZFQKeDYRlsphJGTCgid+wQ1zVYiFzH8mAsoGtPaia2rtWmdTi10NOJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR2P281MB0105
X-TM-AS-ERS: 104.47.11.168-0.0.0.0
X-TMASE-Version: StarCloud-1.3-9.1.1026-28464.007
X-TMASE-Result: 10--15.569800-4.000000
X-TMASE-MatchedRID: byfwvk+IcRn5ETspAEX/ni5SIQSguq+gGfP6Q7XnYoeRnjfvXVSKt689
	5HEdohSr6lROzfyovSM3TavLrREKnHAHTluwxdGFybaMhlRNDfDrlkvw0pZ13DZF3fXwq22PXeA
	eGekCohIr+qWDpaTpageG9+7JmpwrJjpgX+qGOZEJ9830SX03Azsagavr4+KJImJmy502lS0NDH
	XdWeqRGrwY8epx+4ywhH0rjqaZPdIyrV2ubzbrNZ0UyaWO1QCnF1k2re42Ig0hkL0gCMh6DsJi3
	JKzHbmk1mh3V2G9QO8aqShqHxesm0Fp7EpJVf2uOagwGSua5/+YJgzgxqgVT3vBA9C/1eiFSJap
	XYJQvpPYeXOEzfM22dEoO5p+Ouf5muMpo5XKw29WPx536TZMQBomt7e+ksQhJpK4F9wnIiZiyuQ
	OZndK/bpcTKsMs1ZR+gsSeW2jNCfz06lohXENhP08piqRFMnZ40pnJqOe/RX84SWtFYp7wAkrYw
	rjkf4Y
X-TMASE-XGENCLOUD: 26535871-38dd-44cd-b188-7de1eb07b9d1-0-0-200-0
X-TM-Deliver-Signature: 499231C7649B77F7641C2652589B65A8
X-TM-Addin-Auth: QZNHK0YGoM9+6fAtK51X0TLG6DY2VmPM/0/ew2N1HhPjL9FIoZSgDoLXusj
	ylK43Gh2LsvWUy3UsIy02bxw8f2BswD2jTogQam+XGx27kYLeXHkBxFUoyUctSWYPighAdN349g
	NH1u5XfL2eADLAwQY4BP42t6z1dsX1Sp+XWnKPS68qai2kY6G5tyTA2Q4Jwa/MluXyGJD3OyfdN
	kyzAnTHOcYz54mngt1SRf5D2xiKhpvpqn5/UXzkM4k+c0xDGgz/qjnyinqNTqIFz81Uaag6iHx4
	zfT677GY/he1MW8=.GyIAX4l/MAtcJymbQv3IS4avFP0xlmcbB/9TFO1gtbdTMeAeYN5LTx23dR
	NMt0/v1n4Vs0DxMNyq7OAc1E5oktisD/GAhaQb5M3sQxRJDqvdfbI0I9okRJeGdL27y31r7oLhp
	ziO5dEHC1v+aeE/b4dJDK/yGgWgsWrGqgiQ+qusbqnn7odyRuD2aHmjmw/vb9PQ2dyNUaAndebQ
	Td8X5XUckvOIS9tTzxN/wCGD0EDpDho1465I/8cnxd6S1AJljHR+A7ahvHvm86+04A5Fc4OkBIO
	1yaIaVIvvIDgxmnDcduivvy9SxkuGDYjchtxOS3wCaP0EUFk1Sxsb/ukSzg==
X-TM-Addin-ProductCode: EMS
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=opensynergy.com;
	s=TM-DKIM-20210503141657; t=1718885197;
	bh=O0GMQ9dOhVakRCX8D0CnxQRmxu0Ue/8ECkjt1UD/ANk=; l=2433;
	h=Date:From:To;
	b=vN1QuG8lEc7Slb1lLFjabqgL6FO1yNrOM8VDVAg0tft3o4YklD8d3vViWixjBCa9P
	 eKv+3IbrjuZKO4JX+SoaKrjWXRKRNHbrFJ7xhriTuNv9mL9YCym507NlWCf0BpWgmg
	 Z0x7tjb4F5ga0gQbSKYuDPyBur3YGK4PWE9pZdomLuxxbsLcZYmyZHL0TXvCIJC5Zk
	 lcP/VHrLe7DfD/cTTqg8t2JcHNjhzFUkNAOa+vdOpCapehzKfaG+uiQclwbjtbJFV0
	 /DwqngAUVdBTRteGB7mt7lW5rZ5HyIp4i181pgiKMQA1/eI+n8NLaksQhxyolZqxDS
	 7QXo/8KLZgKkA==

Changing virtio-dev address to the new one.

On 15.06.24 09:50, David Woodhouse wrote:
> On Mon, 2023-12-18 at 08:38 +0100, Peter Hilber wrote:
>>
>> +int viortc_hw_xtstamp_params(u16 *hw_counter, enum clocksource_ids *cs_id)
>> +{
>> +       *hw_counter = VIRTIO_RTC_COUNTER_ARM_VIRT;
> 
> Hm, but what if it isn't? I think you need to put this in
> drivers/clocksource/arm_arch_timer.c where it can do something like
> kvm_arch_ptp_get_crosststamp() does to decide:
> 
>          if (arch_timer_uses_ppi == ARCH_TIMER_VIRT_PPI)
>                  ptp_counter = KVM_PTP_VIRT_COUNTER;
>          else
>                  ptp_counter = KVM_PTP_PHYS_COUNTER;
> 
> 
>> +       *cs_id = CSID_ARM_ARCH_COUNTER;
>> +
>> +       return 0;
>> +}
> 

I had such a check in v1, but Marc Zyngier didn't like the distinction [1,
2] - maybe also exposing the timer through a generic helper was not
desired. Quoting from [2]:

>> This was the rationale to come up with the physical/virtual counter
>> distinction for the Virtio RTC device. Looking at extensions such as
>> FEAT_ECV, where the CNTPCT_EL0 value can depend on the EL, or FEAT_NV*,
>> it might be a bit simplistic.
> 
> Not just simplistic. It doesn't make sense. For this to work, you'd
> need to know the global offset that KVM applies to the global counter,
> plus the *virtualised* CNTPOFF/CNTVOFF values that the guest can
> change at any time on a *per-CPU* basis. None of that is available
> outside of KVM, nor would it make any sense anyway.
> 
>> Does this physical/virtual counter distinction sound like a good idea?
>> Otherwise I would drop the arch_timer_counter_get_type() in the next
>> iteration.
> 
> My take on this is that only the global counter value makes any sense.
> That value is already available from the host as the virtual counter,
> because we guarantee that CNTVOFF is 0 when outside of the guest
> (well, technically, outside of the vcpu_load/vcpu_put section).

So I put the assumption that the virtual counter will always be the right
choice for current Linux kernels, from the Virtio device POV.

Thanks for the comment,

Peter

[1] https://lore.kernel.org/lkml/20230630171052.985577-1-peter.hilber@opensynergy.com/T/#ma8d596de1cbc8f4a78a18b2aa995db18423494a7
[2] https://lore.kernel.org/lkml/20230630171052.985577-1-peter.hilber@opensynergy.com/T/#m65fa1d715933360498c4e33d7225e4220215a9d6
