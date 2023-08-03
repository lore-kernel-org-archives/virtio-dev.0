Return-Path: <virtio-dev-return-13450-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407D3C001DF
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:39:29 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id A09A87C6A7
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:39:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 9BD3A98683A
	for <virtio-dev@archiver.kernel.org>; Thu,  3 Aug 2023 11:39:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 905F29866C1; Thu,  3 Aug 2023 11:39:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 7DD2C9866B1;
	Thu,  3 Aug 2023 11:39:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aUXrk0hAEXE3ZMm2WL+eIfoEJqHUEQQXtpCCkMwfkhtmgQstPcLyUiC49Z/tNtgE2ESOycJ2IDBC3KL4na3ff8RHxQdylHRhcm9ESxcqPTXDk3QyGQaEp7XnEDUGXREjyf+CiTMpEHv6FxUbkLp3dbY4Beg+ntiO6F0b4BNuNsdm1xUiw/DMKoNXUfjkG3+D6oaYCjvVkTDwv+EFMiEaG4nmDg69/nguqUpfiZ3EnfQNjC+Xbi3kCx1MHLLeDbxpVmNOxJ/rGe+W5Zk3T0Gz6amfMhDyZKTtDviRvS/oCbQ2nLTgzjdITz/KUc/qbOy7I5SSZUCvocj4AHTzwbMksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bkHhXLKbHiw1zMdAg5QePOaqNf9OwiMUBHc2Ruiv27U=;
 b=PZlHmzdNFgDYozZKjKxmhx4xCK1DPkL99sdjpKxnsbZXcVj2c0GqdZXCqQ+1k98ukibYmL7kS1zioK8L365qZq2VZmJ2KiqsoEVzHrAitALVo5YtMuoo1khBw05YcjV85qXBAoK+li3/sHoFuPfvgmDiZKs93l8JtG6zltmWStioNHdrRwe4wMGS2kS67rl9CmJ2X0xFU/kXvrEVvHfkasrjcNRwXxGnBmuPVjKac5eYcPC85jCf7kWkQO+Zk+lH9m8HmdfmQguqpOsMt5Bs6E8aYJZ1vf5DlKuzbzygtTTqJcZa9974mSNXwqXUKQrHt9Zi3ngMENQLIUCSkzEZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Thread-Topic: RE: RE: RE: [RFC] virtio-net: support access and control the
 member devices
Thread-Index:
 AQHZxeT2Q5D2+syVdECqHrje6hzlHq/YUmCAgAAS74CAAAGPkIAAAc8AgAACoHCAAAFdAIAAAN7QgAACXwCAAAH+cA==
Date: Thu, 3 Aug 2023 11:39:20 +0000
Message-ID:
 <PH0PR12MB5481E104793F9E68E1DC95CADC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230803083150.46745-1-xuanzhuo@linux.alibaba.com>
 <20230803054333-mutt-send-email-mst@kernel.org>
 <1691059929.235804-1-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481B5B3C5366CCACB221083DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691060652.3764465-2-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB548191AE225B08BACFC0C350DC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691061508.9066079-5-xuanzhuo@linux.alibaba.com>
 <PH0PR12MB5481CB7BE555F4672394A6ECDC08A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1691062204.2378864-7-xuanzhuo@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|MN0PR12MB6003:EE_
x-ms-office365-filtering-correlation-id: 710ec7d4-b5ba-40be-6f03-08db9416471b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xe0KPNZ3AbpLPFgjL7lYNSPJO+YdLJM5kHvRlVHXSi5cNxK9Kh5YTsZTSyOHFE6qFNj1626wbg8/Spo1biq2C3etikqtPT7tKplTYy6IGqoSUy0PH5pSHQZ8pMZAmu6K0wKyl0islV/qLJpePpsXWCzCxj9fiSZHRqJ9bZ0kPnOS6tB5x39r3rkYorIurmpEe0mHBaaXeDySjbyNN2W+NT5PDjZehbGhT4IE6VQTqfK0GkT0T/JGSjcqfOgOWgGdr8pNx65l4sFMuGtf2AJ/dD+EQVJvkJZonxUeyqf7XaFPg5f+wcERMqOlOqJRA/biR9L1tmVI9Yv/gVJm9X9GIQwvK7Z1H80jJrn3h+cRgAq9xvXVOsCNYgxl+1o3UIwIZtDMrjgG41Cy2ZhI2xW0JOSAwOzdXtMpB8k4f0pZWup3jAQ1KUmzvj82hicx7sS/o2Thbm+pPuITseRburfND57Bmx7s7byyCAFCouHS/slg0JGkkLJxAA5YtGhrEQQtCl62v6p8ITJjkpvoR/jSo7GWvHhTCzmzT9lGvXlE2GxiPu0rU9SM9hbalNA7P6NQfdX5kq/7hPwyo9geBjaOGTEQFnI18ws+QQ3qxaEiYyDDFeCO8Dl02VFYRJP/sgZn
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(451199021)(6506007)(83380400001)(26005)(186003)(4744005)(316002)(76116006)(2906002)(66946007)(4326008)(64756008)(66446008)(66476007)(66556008)(5660300002)(6916009)(41300700001)(8676002)(8936002)(7696005)(71200400001)(52536014)(9686003)(54906003)(478600001)(55016003)(38100700002)(122000001)(33656002)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qdD1rBACLPHmqL+I8Q3+RwIbBMcS0n0L0BNZi0OZIc/896KChqlYSke4PAcS?=
 =?us-ascii?Q?GRPK27UiQJKCZQAl33RVJNyDvJnD4atgu2kapqHCeFaYuYB8ab4TEPvWIWZM?=
 =?us-ascii?Q?sNsYZH0sZ8Cg0VibcGr4TKDKpGCkqeQ7Sl3UzhJeyOZ9MrUYAMQepfAuVk0C?=
 =?us-ascii?Q?jDEs9Ort58GL8LlGmB/cs4dZsLwFoojGzUfe0XhebuSRpFdpNXyPJMLhQ7oG?=
 =?us-ascii?Q?9ttUAiSYGqR0lvnDtqy7zkiLmY6jtdjZ+y0bhftNeLP8rLIieb19pSA7L4Zj?=
 =?us-ascii?Q?fRZf9AdTG3+Vi3RevT7nzqWj3X2LGuQT/kTWxSD6B34d7e5I4nFS5AvtynUW?=
 =?us-ascii?Q?Eoc7UG3tl1vqgo5TMIsavB6lc2LrZElkwlrIUU2+XomJKfmsc4vV5jnWR8X9?=
 =?us-ascii?Q?zR/IR6uiLpRVAcOW3iockxoAf2sMyHucBXsuL+cF6xlsp+RIX3TSlV+GAuMU?=
 =?us-ascii?Q?g7w4htyQ3n1S3XPhuUfx7kf4CycpX3o2hv+5LDCwvTvCR6klOC9+nW0/IJ6j?=
 =?us-ascii?Q?oMmiXD/vXOcsOEdmTKaPSstKGT3gPU9Vj/YAMqJ/BbCOyFeeYvZ3f/bb4owK?=
 =?us-ascii?Q?6MWM7nXl/yQUXNynk4p/kpSyH1AYeBxMTGNXOo6WDU7Xnk9t1SSK4gjmN0ES?=
 =?us-ascii?Q?Us1Mfom1CRAqUMeY0Y+eMcv7/3lAXj6e4qKpA7neO5e7R/rxsPNXE1p9qOk+?=
 =?us-ascii?Q?U1pyxi88BL5UCOKl6C/BrjhROOW6nNESMOJJFBK6qXUmXIGmb7D0U/W39mGA?=
 =?us-ascii?Q?Km1rFFcFQfcSJRrXlz73S81goAZHi87k6ZjEsrGqfgI/kcidE1N8mdNhthwz?=
 =?us-ascii?Q?vmQMhH6ealqXUHf0ZQ/QiSxPhCQRwjA/fB+ZiSEOI9xddjcE1ALLfLjPfqmI?=
 =?us-ascii?Q?y3ATdDSsGZR+c8iXRJ+t/v5obLGJ5/VB8toawoQE6CwAnbcLy04FweJW3aF4?=
 =?us-ascii?Q?nmcGlBM2NxwfR1+QXWJdvc9zx0o/VEf01oVnPGElACEiEEW4HdQVIhtOiOKr?=
 =?us-ascii?Q?Ppl9qp0oeSTV2axXQ0VoxdRJW5bvMQIHKRxMSNw01hXbGyJl0Os/ml5FrBEC?=
 =?us-ascii?Q?OG6SGctu8H2dxUQIp7oMuPUTJZ8ZaIN/elVLgThnCvckWi4fasZS/tlBcm8x?=
 =?us-ascii?Q?aRXmu3xEimKcsfpCFVVuIBpWqVfpdFENA0ZeflFL4NK3GnxqNhBEJy4joxOM?=
 =?us-ascii?Q?Oxz8IFvgl2/e6BrTnoE1Kbcl9336S6in4Z+NFHEev+tnP7JDZP1n4eglMLfv?=
 =?us-ascii?Q?zWoi/T3fkgih7rhnGFbVVI3vEjPoha+wu7KfpXS1O/tQ7K1eywZntsv5ZzV+?=
 =?us-ascii?Q?Kjy+3Yk/spBsSjDjICb+wzKtcKJS0vY2lnH5uhHsebm9S/zR7sipPjAp897u?=
 =?us-ascii?Q?MFoBFP8q2M1xSCOK95tjNdaHWGL9Ah+3W1+LomXNV5dq9NGJnZyufJUatKZ/?=
 =?us-ascii?Q?NwIkY9ofZoNtWYZK/Hs66XxMDwpUX5JoDWSAeO8hPm14wwnKDnFKXb/fXrIB?=
 =?us-ascii?Q?L/QaHo3fHxH+/CyjtgLNwFs1VOSmxG+uYRkkbgu321I+apXP+cFHqfKg60l4?=
 =?us-ascii?Q?tp9n8mK05mtK5l197EY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 710ec7d4-b5ba-40be-6f03-08db9416471b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2023 11:39:20.6190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XPK5YWk1QCb2VqFYr9hZ6vBlj6WVBomeHsvoF91uMTVuiPvl9uRjZ6Uh5kiWenHex/WnG0k6brNuOoVkcrNvPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003
Subject: [virtio-dev] RE: RE: RE: RE: [RFC] virtio-net: support access and control the
 member devices


> From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Sent: Thursday, August 3, 2023 5:00 PM


> > Admin command is what is suitable for device management, including
> features and configspace fields setup.
>=20
> I agree.
>=20
> But some configuration such as mac, ip(eswitch rule) for vfs that are sui=
table
> for the admin queue?
Mac, why not.

Eswith rules should be programmed through the flow vq, that we are working =
with Heng, Satananda and David.
So, a PF or a switching device (new virtio device type) will have the flowv=
q as well.


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

