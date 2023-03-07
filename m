Return-Path: <virtio-dev-return-11493-virtio-dev=archiver.kernel.org@lists.oasis-open.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ws5-mx01.kavi.com (ws5-mx01.kavi.com [34.193.7.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E933CC678D5
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:09:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis.ws5.connectedcommunity.org [10.110.1.242])
	by ws5-mx01.kavi.com (Postfix) with ESMTP id 5D35E157EEA
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:09:28 +0000 (UTC)
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 562049866E1
	for <virtio-dev@archiver.kernel.org>; Tue,  7 Mar 2023 19:09:28 +0000 (UTC)
Received: from host09.ws5.connectedcommunity.org (host09.ws5.connectedcommunity.org [10.110.1.97])
	by lists.oasis-open.org (Postfix) with QMQP
	id 476D49866DC; Tue,  7 Mar 2023 19:09:28 +0000 (UTC)
Mailing-List: contact virtio-dev-help@lists.oasis-open.org; run by ezmlm
List-ID: <virtio-dev.lists.oasis-open.org>
Sender: <virtio-dev@lists.oasis-open.org>
Precedence: bulk
List-Post: <mailto:virtio-dev@lists.oasis-open.org>
List-Help: <mailto:virtio-dev-help@lists.oasis-open.org>
List-Unsubscribe: <mailto:virtio-dev-unsubscribe@lists.oasis-open.org>
List-Subscribe: <mailto:virtio-dev-subscribe@lists.oasis-open.org>
Received: from lists.oasis-open.org (oasis-open.org [10.110.1.242])
	by lists.oasis-open.org (Postfix) with ESMTP id 2DC659866DA;
	Tue,  7 Mar 2023 19:09:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at kavi.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mms5UXTh6jQJYMcDKBmJInvpdcXze8OISLZo1T7urUZ0eHsWJcyc+OV9yfWmiduX4Qh00mZctmDBbgoQCFRzzoHJaQrqtNtwH3g6Q60PmsfMLF71ob/67X1XOhoh9L8AnzkGzCpIH2BMPMP4kGgTTIjk/I8S2tX6UU8D9bkD0vk04LlmQ39FGYfmg6e6clupnLP7nQfeI+4wTW+TjG2ZYiVO7wOHhBTx1Eijl8CWLMqPKetlBuvQQndnFuskDsOtY+nLkgfGgKe2FJ2pRrQGRzfxt4boBsxbp6AbhBQqW5XK4d/CJDNYeDE0RJ+Iv3E0msX7DYyx4X0okTi5uvMI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=haUMQCYiW1IJRSJiLyGYlIxf0Y8Gsi6GN19Ko8/ow0c=;
 b=h6asLY9Aq5B03VNZXimyjwvdXm2Smsi2iNrp3ihd6caUveSUXhWRLHuI09A4m721ec2YKydliE7UKUb9HPf/EyNC0wXvCHEJ0XQMK7Ecw4+w21e8naKkg8hSqjK+CTsQbSqK0brtPpvvHx+fZMN3xQ8OByAwL1Ly8D5HfYE4ZdfO+IB1Gf7YKsSASvQKtgrXQ1+qUp7rCm3bTDRp1y4uV3YFjKvUNMja/yFCYyvht2qwg9Bl7lppkcWpJvkYm3bkvT9PtvTqdScYD64j7nPCovn2FKiXTEUh9pYOaVRCLiY0R3j4z+ePr4diuV5En6KwXfHf1zZEBg398ZOdzCTcTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
From: Parav Pandit <parav@nvidia.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jiri Pirko <jiri@nvidia.com>
CC: "Michael S. Tsirkin" <mst@redhat.com>,
	"virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
	"virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
	"jasowang@redhat.com" <jasowang@redhat.com>, "cohuck@redhat.com"
	<cohuck@redhat.com>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"nrupal.jani@intel.com" <nrupal.jani@intel.com>, "Piotr.Uminski@intel.com"
	<Piotr.Uminski@intel.com>, "hang.yuan@intel.com" <hang.yuan@intel.com>,
	"virtio@lists.oasis-open.org" <virtio@lists.oasis-open.org>, Zhu Lingshan
	<lingshan.zhu@intel.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>, Shahaf
 Shuler <shahafs@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Thread-Topic: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues
Thread-Index:
 AQHZTQegoqm3ZFh/hkOgShx3CSU6867n9EmAgAA5TwCAAOB7AIAAAnmAgABw4oCAAnEigIAA8WoAgAAESwCAALRJAIAAfs6AgADhIgCAAG6cgIAACAYAgABB54CAAADF8A==
Date: Tue, 7 Mar 2023 19:09:17 +0000
Message-ID:
 <PH0PR12MB5481B78E6408C1A7C04FDABFDCB79@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230303083213-mutt-send-email-mst@kernel.org>
 <20230303202133.GA2901137@fedora>
 <20230305043419-mutt-send-email-mst@kernel.org>
 <20230306000302.GA244754@fedora>
 <20230305191351-mutt-send-email-mst@kernel.org>
 <20230306110340.GA35392@fedora>
 <20230306133525-mutt-send-email-mst@kernel.org> <ZAbvxj+7lgaI1HkI@nanopsycho>
 <20230307143911.GC124259@fedora> <ZAdTSiVJGSrRIqZ3@nanopsycho>
 <20230307190347.GA153228@fedora>
In-Reply-To: <20230307190347.GA153228@fedora>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|CY5PR12MB6574:EE_
x-ms-office365-filtering-correlation-id: c37eaddf-e4be-4456-af18-08db1f3f732c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1YqjM9SyHuhD4Q7YEpsqreDBEghFud/G5mwyC8KdbZlmFGpk8Ntp7xUyWyw+YENi/zzC0IcdBeTZlzj100+2sbcS1gHDg75WB57pbLJwIsFsfNd3w2Ba8rnWfPYa5XMGhBPvCdRwhARLhLWSA6qh0I+27/Js5OykUB+P4C+DA+hW4EGdCU+h1ZWZ51liDZlAjlKxyToavPGfzzufNsofX5ZBs/LymgE5UuMA44BpdfZkrtDBtqbPVuVTJA/g6wpsm/4cL3a0xTJA1xyiCY49YrODQI7Gx/YyExPddxh0PGLo3AqJYYrWn2bYGdnbNI/JXL/nKVCvmZ4+TG/qC0LZn3GhqaAzVq4kOfvhN+kIwd8XYNPlOBkRJUW4Bw5LglnLSY6B7epHp5HWHdbOC2arjnTRPZmozyV4ZiSun0mhG003kHCH2txBu//pnLD1Y63acyiSNgOjCY0wsco/z55AhoofPNJGDZuXtgivcUpOYfCE2Cf4wIiFl29OQtaCIfFIORLTPdiyWIMYYR+/Hvtejy+1opOizJRjWxxic40vxJ6xTO7K7pcu2mIcVAUV4QY2E7eZQn1FeGT/mutZ4MDgGAEKg8BGrXV75B+xCF4DqnFB31NJmc3Ye3oE4kVt98RxkF5R9lxT0IYFRWrWNg/JIwDzugKktB5BoWJgMBsnc16cj7nvaSWS8W90OdbfdDc88j1Q+OYNIWv91u97nMTjAw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(451199018)(6636002)(316002)(110136005)(33656002)(54906003)(55016003)(38070700005)(86362001)(107886003)(6506007)(83380400001)(38100700002)(9686003)(41300700001)(71200400001)(7696005)(5660300002)(52536014)(7416002)(8936002)(478600001)(186003)(122000001)(26005)(4326008)(64756008)(66446008)(4744005)(66946007)(8676002)(66556008)(2906002)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yZWrjeughl5wILm1eZXvXHrfFKxa/1m+UZfWGqCGpyDRaDT/vo7pci4P+Fz7?=
 =?us-ascii?Q?4YfZ4V0vyM5bE5CSGKfg/QTwI5FSEpur7nA3I2dESV1LWCf5TZoOLH17Ybrq?=
 =?us-ascii?Q?HpnuegbUP+hTpWkgXm8Vcc4Wbd8FOUvl5Y6xrXGlAX07HVNyh1tv0iVmIx/p?=
 =?us-ascii?Q?LzvlKQj8I1TtBS12YHbSLff28KY6osMkMmXkrvWdp6HjBfylz1VyqXFN1ZgP?=
 =?us-ascii?Q?80q1ji8C0FwpRUc1S+lzknZodInKoWIw0HDxKoO0zt5yVXjSLogLPyiwcGyc?=
 =?us-ascii?Q?wu+cC/1fmYXffYLeCPemkscGg38MxVplwQVWypyTv5DoWsuiV9p2PhHhIQnJ?=
 =?us-ascii?Q?BQye4WfDDaMHJjpCKxsh2c1mdBlw6yL9hd6ayrwX9MWQZJzucakMTLZuKZMs?=
 =?us-ascii?Q?y2aydTB7jLr1cVVMiTXytLTzhl+sESyfni0v4OgZV5sPW0H+FkgUG3ziZgz+?=
 =?us-ascii?Q?es0Ir6mGCyEuPlu+QppKmE+mJ1NR47IsSkVGr/nAMpks9xX1redxEQjzD9hp?=
 =?us-ascii?Q?/WJ8F9LQLiszLakS3+0woUcbLg1yByGQ2t3jtCStVYF2v2fg2Ed+GHCd6Uv1?=
 =?us-ascii?Q?VQyg6LEjt35ch/h8z8UoInB4K+j6mtNWG4lHn/mTBOw5iWLEWBrz6OJwI8/h?=
 =?us-ascii?Q?wl0KwXSR4ydgnJ8KQN0OLUodJBCf/J3++ybpAiGwGvdxHtVOg9+GRsrHOeWr?=
 =?us-ascii?Q?ympESvp9xjD+cKedeFV6Nli2pfsA9YlCYk50W1KwoG4Vx39Q8Oflc0n9fAUB?=
 =?us-ascii?Q?h7TVQM8u7h9+QFy4xzqTFbjbzs6+VpzD0WuDchB/Mn/Ae/WoGYmmugZttWeR?=
 =?us-ascii?Q?1NwgwMx1vFLu4hmgqAztGjSYxLkdkNymdSlm4TJ8iZW0BHMQG1mGrH9Pif/t?=
 =?us-ascii?Q?R7XO90s816RwiytDmgTFKdTsblXBQpwb46GtFdxfwbsgYjwDBE0DW9sCBoNt?=
 =?us-ascii?Q?sf6xEM6XYhdLUjLrv/mkGguAaifJZQSAcOfu7V9ncOmlHUuJk8pu5vwjyHtb?=
 =?us-ascii?Q?wH1svU2xOGX0QE6v48M0amHFSVktKVimcJgJfRb2HfJlQDyXkX2siHD7xxj4?=
 =?us-ascii?Q?xddYq1lRs8EqDJtf1ONi9MQUayE4d7Gsr1vkT/WPUr2LlZixXv8VAl7Rd5ZF?=
 =?us-ascii?Q?y2izeEfwOiCAd9OuDmAsEJAe991Y5O6AyA62mhJqADamlfsT1w2Nx9mKGJO3?=
 =?us-ascii?Q?R9f4duiiihjk9hDIt4jn74IiqDTYX5D8pH01tVGVNsQWIFn4nHB9/K4K14nY?=
 =?us-ascii?Q?V8x8T4yQGMFaz/ePjUVIMDOa6yi9umL/Wwu+3+nDvVtJFYtU3X4N7mvh+wcX?=
 =?us-ascii?Q?oyhYbdBwEsaxQqQwmrEYLOnFtf7eivQazUnN+ZR5RD7sS6Y5TPJ4mYaXxK6k?=
 =?us-ascii?Q?k+kjKXp29N4NRupHmYdgAu8RfvhDaCr7V2HHUHJe5yveHODn1Bg9d2CTc1lU?=
 =?us-ascii?Q?Er0ML5br/I/5/d9avyXDJhqb/gNmHZ+d+x6J6j5vzsFYq/SPDvoYD2F7AajI?=
 =?us-ascii?Q?r+IfrvtwyGmRX3uJp6uGCZKZaldan9Rwc0uaMJIDgLUOOUrn3/Bwn43s2F0N?=
 =?us-ascii?Q?sdlw14mDBzC1sdgCSaM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c37eaddf-e4be-4456-af18-08db1f3f732c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2023 19:09:17.8141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JSo3UTaEDBq2SYYZzvhprFXiLc9sRJx3uAzGpihM1Mr+ZeCCRv8M2alwEcM79z31a6YhBxh1pK3UxxNgd9a0yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6574
Subject: [virtio-dev] RE: [virtio-comment] Re: [virtio] Re: [PATCH v10 04/10] admin:
 introduce virtio admin virtqueues



> From: Stefan Hajnoczi <stefanha@redhat.com>
> Sent: Tuesday, March 7, 2023 2:04 PM

> An alternative is unconditional out-of-order completion, where there are =
no
> per-command ordering rules. The driver must wait for a command to complet=
e
> if it relies on the results of that command for its next command. I like =
this
> approach because it's less complex in the spec and for device implementer=
s,
> while the burden on the driver implementer is still reasonable.
+1.
This has best of both.
1. Command ordering knowledge and hence the decision left to the one which =
issues them. (driver).
2. Ability to execute multiple unrelated commands using a single AQ.
3. stateless device in AQ command execution


---------------------------------------------------------------------
To unsubscribe, e-mail: virtio-dev-unsubscribe@lists.oasis-open.org
For additional commands, e-mail: virtio-dev-help@lists.oasis-open.org

